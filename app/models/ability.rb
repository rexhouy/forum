class Ability
        include CanCan::Ability

        def initialize(user)
                if user.nil?
                        can :read, [Topic, Post, Category, Enroll]
                        can :create, [Post, UserFavorite, Enroll]
                        can :activities, [Topic]
                        can :enrolls, [User]
                        can :customer_sign_in, [User]
                        can :customer_sign_in_check, [User]
                        return
                end
                if user.admin?
                        can :manage, [User, Topic, Category, Post, UserFavorite, Enroll]
                elsif user.partener?
                        can :manage, [Topic]
                        can :read, [Enroll]
                end
                can :read, [Topic, Post, Category, User]
                can :update, [User]
                can :create, [Post, UserFavorite, Enroll]
                can :search, [Topic]
                can :like, [Topic]
                can :enrolls, [User]
                can :activities, [Topic]
        end
end
