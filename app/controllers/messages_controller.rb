class MessagesController < ApplicationController
  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(params.require(:message)
                                .permit(:user_id, :content, :room_id).merge(user_id: current_user.id))
      redirect_to rooms_show_path(id: @message.room_id)
      flash[:alert] = []
      flash[:alert] << 'メッセージを入力してください。' if @message.errors[:content].include?('を入力してください')
      flash[:alert] << 'メッセージは1文字以上で入力してください。' if @message.errors[:content].include?('は1文字以上で入力してください')
      flash[:alert] << 'メッセージは200文字以内で入力してください。' if @message.errors[:content].include?('は200文字以内で入力してください')
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
