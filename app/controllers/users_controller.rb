class UsersController < ApplicationController
  def show
    # 20201114 ユーザ検索機能の実装
    @user = User.find(params[:id])
    @current_user_entry = Entry.where(user_id: current_user.id)
    @user_entry = Entry.where(user_id: @user.id)
    return if @user.id == current_user.id

    @current_user_entry.each do |cu|
      @user_entry.each do |u|
        if cu.room_id == u.room_id
          @is_room = true
          @room_id = cu.room_id
        end
      end
    end
    return if @is_room == true

    @room = Room.new
    @entry = Entry.new
  end
end
