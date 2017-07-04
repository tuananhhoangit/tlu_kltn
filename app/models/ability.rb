class Ability
  include CanCan::Ability

  def initialize user
    can :read, :all
    (can :update, User, id: user.id) if user
  end
end
