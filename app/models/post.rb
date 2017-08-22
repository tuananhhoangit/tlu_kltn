class Post < ApplicationRecord
  has_many :comments, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  belongs_to :user
  scope :posts_sort, ->{order created_at: :desc}
  scope :search_post, ->keywords{where "title LIKE ?", "%#{keywords}%"}

  scope :load_feed, lambda{|id, following_ids|
    where "user_id IN (#{following_ids}) OR user_id = :user_id",
      following_ids: following_ids, user_id: id
  }

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true, length:
    {maximum: Settings.post.content_max_length}
  validates :title, presence: true, length:
    {maximum: Settings.post.title_max_length}
  validate :picture_size

  def all_tags=names
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    tags.map(&:name).join(" , ")
  end

  private

  def picture_size
    return unless picture.size > Settings.post.picture_size.megabytes
    errors.add :picture, I18n.t(".picture_validate")
  end
end
