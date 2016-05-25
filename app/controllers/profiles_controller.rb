class ProfilesController < ApplicationController
  before_action :set_user

  def show
    @posts = @user.posts.order('created_at DESC')
  end

  def edit

  end

  def update
    if @user.update(profile_params)
      flash[:success] = 'Profile updated'
      redirect_to profile_path(@user.user_name)
    else
      @user.errors.full_messages
      flash[:error] = @user.errors.full_messages
      render :edit
    end
  end

  private

  def set_user
    @user = User.find_by(user_name: params[:user_name])
  end

  def profile_params
    params.require(:user).permit(:avatar, :bio)
  end

end
