module ChatHelper

        def avatar_url(user)
                return user.avatar if user.avatar.present?
                image_url("avatar.png")
        end

end
