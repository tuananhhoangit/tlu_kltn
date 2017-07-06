class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  delegate :name, :avatar, to: :user, prefix: true

  validates :user, presence: true
  validates :post, presence: true
  validates :content, presence: true,
    length: {maximum: Settings.post.content_max_length}
end
