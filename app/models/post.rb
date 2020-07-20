class Post < ApplicationRecord
  # タグ生成
  acts_as_taggable

  # PV値測定
  is_impressionable

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  has_many :likes
  has_many :liked_users, through: :likes, source: :user

  has_one :local
  accepts_nested_attributes_for :local

  has_many :post_images, dependent: :destroy
  accepts_attachments_for :post_images, attachment: :image

  # indexページを6個刻みに表示
  paginates_per 6

  # バリデージョン
  validates :post_text, presence: true
  validates :title, presence: true

  def self.search(keyword)
    where(['title LIKE ? OR post_text LIKE ?', "%#{keyword}%", "%#{keyword}%"])
  end

  # 以下通知設定の記述
  def create_notification_by(current_user)
    notification = current_user.active_notifications.new(
      post_id: id,
      visited_id: user_id,
      action: "like"
    )
    notification.save if notification.valid?
  end

  def create_notification_comment!(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visiter_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
  # ここまで
end
