class ApplicationController < ActionController::Base
  # 20201107 ユーザ情報の追加 start
  protect_from_forgery with: :exception

  # ログイン済ユーザーのみにアクセスを許可する（ホームのインデックスページ以外）
  before_action :authenticate_user!, if: proc { !(controller_path == 'homes' && action_name == 'index') }

  # deviseコントローラーにストロングパラメータを追加する
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # ユーザ登録時に以下のストロングパラメータを追加
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name sex birth_date animal])
    # ユーザ編集時に以下のストロングパラメータを追加
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name sex birth_date animal profile image secret])
  end
  # 20201107 ユーザ情報の追加 end

  def check_guest
    email = resource&.email || params[:user][:email].downcase
    redirect_to root_path, alert: 'ゲストユーザーの編集・削除はできません。' if email == 'guest@example.com'
  end

  def destroy_room
    user_entries = Entry.where(user_id: current_user.id)
    return unless user_entries

    user_entries.each do |entry|
      entry.room.destroy
    end
  end
end
