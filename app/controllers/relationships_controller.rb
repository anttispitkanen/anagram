class RelationshipsController < ApplicationController


  def follow_user
    @user = User.find_by! user_name: params[:user_name]
    if current_user.follow(@user.id)
      respond_to do |format|
        format.html {redirect_to root_path}
        format.js
      end
    end
  end

  def unfollow_user
    @user = User.find_by! user_name: params[:user_name]
    if current_user.unfollow(@user.id)
      respond_to do |format|
        format.html {redirect_to root_path}
        format.js
      end
    end
  end

  def follow_yourself
    if current_user.follow(current_user.id)
      flash[:success] = "Awesome first post!"
    end
  end


end
