class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :post_tags
  has_many :tags, through: :post_tags

  belongs_to :user

  scope :posts_sort, ->{order created_at: :desc}
end
