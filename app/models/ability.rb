class Ability
        include CanCan::Ability

        def initialize(user)
                if user.nil?
                        can :read, [Topic, Post, Category]
                elsif user.admin?
                        can :manage, [User, Topic, Category, Post, UserFavorite]
                else
                        can :read, [Topic, Post, Category, User]
                        can :update, [User]
                        can :create, [Post, UserFavorite]
                        can :search, [Topic]
                        can :like, [Topic]
                end
        end
end
