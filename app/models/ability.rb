class Ability
        include CanCan::Ability

        def initialize(user)
                if user.admin?
                        can :manage, [User, Topic, Category, Post, UserFavorite]
                else
                        can :read, [Topic, Post, Category]
                        can :create, [Post, UserFavorite]
                        can :search, [Topic]
                        can :like, [Topic]
                end
        end
end
