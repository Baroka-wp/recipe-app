# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
      user ||= User.new # guest user (not logged in)
    can :read, :all
    can :manage, :all, user_id: user.id
  end
end
