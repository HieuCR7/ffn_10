class Ability
  include CanCan::Ability

  def initialize user
    if user.blank?
      can :ready, only: %i(index)
    elsif
      if user.admin?
        can :manage, :all
      else
        can :manage, User, id: user.id
      end
    end
  end
end
