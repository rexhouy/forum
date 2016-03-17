class Ability
        include CanCan::Ability

        def initialize(user)
                if user.nil?
                        can :read, [Topic, Post, Category]
                elsif user.admin?
                        can :manage, [User, Topic, Category, Post, UserFavorite, Enroll]
                else
                        can :read, [Topic, Post, Category, User]
                        can :update, [User]
                        can :create, [Post, UserFavorite, Enroll]
                        can :search, [Topic]
                        can :like, [Topic]
                        can :enrolls, [User]
                end
        end
end
