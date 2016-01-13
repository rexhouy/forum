module ChatHelper

        def avatar_url(user)
                return "avatar.png" if user.avatar.nil?
                user.avatar
        end

end
