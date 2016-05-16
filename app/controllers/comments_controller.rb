class CommentsController < ApplicationController
  before_action :set_post


  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      flash[:success] = "Comment posted!"
      redirect_to :back
    else
      flash[:alert] = "Something went awfully wrong!"
      render root_path
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    flash[:success] = "Comment removed!"
    redirect_to root_path
  end

  def new

  end







  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end




end
