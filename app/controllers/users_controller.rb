class UsersController < ApplicationController
  def show
    # 20201114 ユーザ検索機能の実装
    @user = User.find(params[:id])
  end
end
