class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :unlike]
  before_action :owned_post, only: [:edit, :update, :destroy]

  def index

    @posts = Post.of_followed_users(current_user.following).order('created_at DESC').page params[:page]
    
  end

  def browse
    @posts = Post.all.order('created_at DESC').page params[:page]
  end

  def show
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      #creating a following relationship for the user itself upon creating the first post
      #therefore the user will see their own posts in the index view
      unless following_self?
        id = current_user.id
        Follow.create(follower_id: id, following_id: id)
      end
      flash[:success] = "Your post has been created!"
      redirect_to posts_path
    else
      flash.now[:alert] = "Post couldn't be created. Please check the form."
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Your post was updated!"
      redirect_to posts_path
    else
      flash.now[:alert] = "Update failed. Please check the form."
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post deleted."
    redirect_to root_path
  end


  def like
    if @post.liked_by current_user
      respond_to do |format|
        format.html {redirect_to :back}
        format.js
      end
    end
  end

  def unlike
    if @post.unvote_by current_user
      respond_to do |format|
        format.html {redirect_to :back}
        format.js
      end
    end
  end


  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def owned_post
    unless current_user == @post.user
      flash[:alert] = "That post doesn't belong to you!"
      redirect_to root_path
    end
  end

  def following_self?
    id = current_user.id
    relationship = Follow.find_by(follower_id: id, following_id: id)
    return true if relationship
  end

end
