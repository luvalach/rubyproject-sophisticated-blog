class Ability
  include CanCan::Ability

  def initialize(user)
      if user.nil?
        can :read, Blog
      else 
        can [:read, :create], Blog
	can [:read, :create], Post
	can [:read, :create], Comment
	can [:read, :create], Like
        if user.admin == true
          can :manage, :all
        else
          can [:update, :destroy], Blog, :user_id => user.id
          can [:update, :destroy], Post, :user_id => user.id
          can [:update, :destroy], Comment, :user_id => user.id
	  can [:update, :destroy], Like, :user_id => user.id
        end
      end
  end
end
