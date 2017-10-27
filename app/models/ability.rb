class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else
      can :manage, User, id: user.id
      can :read, Product
      can :manage, Comment
      cannot :destroy, :all
    end
  end
end