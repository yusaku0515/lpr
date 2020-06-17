class Comment < ApplicationRecord

    has_many :notifications, dependent: :destroy
	belongs_to :user
	belongs_to :post

    # バリデーション
	validates :comment, presence: true
end
