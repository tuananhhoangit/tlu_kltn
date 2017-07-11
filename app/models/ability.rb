class Ability
  include CanCan::Ability

  def initialize user
    alias_action :update, :destroy, to: :modify
    return unless user
    can :destroy, [User, Post, Comment] if user.is_admin
    can :update, User, id: user.id
    can [:create, :modify], Post, user_id: user.id
    can [:create, :modify], Comment, user_id: user.id
  end
end
