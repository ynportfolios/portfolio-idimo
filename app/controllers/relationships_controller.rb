class RelationshipsController < ApplicationController
  before_action :set_user

  def create
    following = current_user.follow(@user)
    if following.save
      flash[:success] = 'フォローしました。'
      redirect_to users_show_path(id: @user.id)
    else
      flash.now[:alert] = 'フォローに失敗しました。'
      redirect_to users_show_path(id: @user.id)
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following
      flash[:success] = 'フォローを解除しました。'
      redirect_to users_show_path(id: @user.id)
    else
      flash.now[:alert] = 'フォロー解除に失敗しました。'
      redirect_to users_show_path(id: @user.id)
    end
  end

  private

  def set_user
    @user = User.find(params[:follow_id])
  end
end
