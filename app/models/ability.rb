class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :destroy, Favourite do |f|
      f.user = user
    end
    can :create, Favourite do |f|
      f.user != user
    end
  end
end
