class ApplicationController < ActionController::Base
  def check_guest
    email = resource&.email || params[:user][:email].downcase
    redirect_to root_path, alert: 'ゲストユーザーの編集・削除はできません。' if email == 'guest@example.com'
  end
end
