module ChatHelper

        def avatar_url(user)
                return user.avatar if user.avatar.present?
                image_url("avatar.png")
        end

        def user_name
                return "#{session[:user_tel][0..2]}****#{session[:user_tel][7..11]}" if session[:user_tel].present?
                ""
        end

end
