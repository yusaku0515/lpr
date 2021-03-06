class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookmarks, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  def already_liked?(post)
    likes.exists?(post_id: post.id)
  end

  has_many :posts, dependent: :destroy

  # 通知機能
  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

  attachment :icon_image

  # バリデーション
  validates :encrypted_password, confirmation: true, length: { minimum: 6 } # パスワードが確認用と一致しているか

  # ゲストログイン用
  def self.guest
    find_or_create_by!(email: 'guest1@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
