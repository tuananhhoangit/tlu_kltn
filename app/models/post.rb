class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  belongs_to :user

  scope :posts_sort, ->{order created_at: :desc}

  mount_uploader :picture, PictureUploader

  validates :user, presence: true
  validates :content, presence: true, length:
    {maximum: Settings.post.content_max_length}
  validates :title, presence: true, length:
    {maximum: Settings.post.title_max_length}
  validate :picture_size

  private

  def picture_size
    return unless picture.size > Settings.post.picture_size.megabytes
    errors.add :picture, I18n.t(".picture_validate")
  end
end
