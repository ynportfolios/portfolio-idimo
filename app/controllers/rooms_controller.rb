class RoomsController < ApplicationController
  def index
    user_entries = Entry.where(user_id: current_user.id)
    return unless user_entries

    @room_informations = []
    user_entries.each do |entry|
      other_user_entry = Entry.where.not(user_id: current_user.id).find_by(room_id: entry.room.id)
      @room_informations << { other_user: other_user_entry.user, room: entry.room }
    end
  end

  def create
    @room = Room.create
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to rooms_show_path(id: @room.id)
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entries = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
