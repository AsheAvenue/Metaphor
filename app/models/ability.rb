class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.has_any_role? :admin, :superadmin
      can :manage, :all
    else
      can :read, :all
    end
  end
end
