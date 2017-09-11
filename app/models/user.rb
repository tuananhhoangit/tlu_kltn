class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  validates :name, presence: true,
    length: {maximum: Settings.user.name_max_length}
  validate :avatar_size

  scope :users_sort, ->{order id: :asc}
  scope :search_user, ->keywords{where "name LIKE ?", "%#{keywords}%"}

  has_many :posts, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  def follow other_user
    active_relationships.create followed_id: other_user.id
  end

  def unfollow other_user
    following.delete other_user
  end

  def following? other_user
    following.include? other_user
  end

  def feed
    following_ids = "SELECT followed_id FROM relationships
      WHERE follower_id = :user_id"
    Post.load_feed id, following_ids
  end

  private

  def avatar_size
    return unless avatar.size > Settings.user.avatar_size.megabytes
    errors.add :picture, I18n.t(".picture_validate")
  end
end
