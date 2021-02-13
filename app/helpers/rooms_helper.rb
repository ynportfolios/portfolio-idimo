module RoomsHelper
  def encourage_following_notice_messages!
    return unless @messages.present?

    other_user_messges = @messages.reject { |message| message.user.id == current_user.id }
    return unless other_user_messges.present?

    return if current_user.following?(other_user_messges[0].user)

    return unless (other_user_messges.length >= 5) && (@messages.length - other_user_messges.length >= 5)

    flash.now[:notice] = "#{other_user_messges[0].user.name}さんをフォローしてみませんか？（プロフィール画像を公開している場合、相互フォロー時に相手ユーザから閲覧されます）"
  end
end
