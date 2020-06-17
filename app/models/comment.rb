class Comment < ApplicationRecord

    has_many :notifications, dependent: :destroy
	belongs_to :user
	belongs_to :post

    # バリデーション
	validates :comment, presence: true

	validates :rate, numericality: {
       less_than_or_equal_to: 5,
       greater_than_or_equal_to: 1 }, presence: true
end
