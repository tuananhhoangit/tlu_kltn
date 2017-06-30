class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  validates :name, presence: true,
    length: {maximum: Settings.user.name_max_length}
  validate :avatar_size

  has_many :posts, dependent: :destroy
  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: :follower_id, dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: :followed_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :comments, dependent: :destroy

  mount_uploader :avatar, AvatarUploader

  private

  def avatar_size
    return unless avatar.size > Settings.user.avatar_size.megabytes
    errors.add :picture, t(".picture_validate")
  end
end
