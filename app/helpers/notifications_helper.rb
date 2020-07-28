module NotificationsHelper
  def notification_form(notification)
    @visiter = notification.visiter
    @comment = nil
    your_post = link_to 'あなたの投稿', post_path(notification), style: "font-weight: bold;"
    @visiter_comment = notification.comment_id
    # notification.actionがlikeかcommentか
    case notification.action
    when "like"
      tag.a(notification.visiter.first_name, href: user_path(@visiter), style: "font-weight: bold;") + "が" + tag.a('あなたの投稿', href: post_path(notification.post_id), style: "font-weight: bold;") + "にいいねしました"
    when "comment" then
      @comment = Comment.find_by(id: @visiter_comment)
      tag.a(@visiter.first_name, href: user_path(@visiter), style: "font-weight: bold;") + "が" + tag.a('あなたの投稿', href: post_path(notification.post_id), style: "font-weight: bold;") + "にコメントしました"
    end
   end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
