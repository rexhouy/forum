class ApplicationController < ActionController::Base
        # Prevent CSRF attacks by raising an exception.
        # For APIs, you may want to use :null_session instead.
        protect_from_forgery with: :exception
        include CanCan::ControllerAdditions

        WillPaginate.per_page = 20

        before_action :auth_user
        def auth_user
                authenticate_user! unless params[:controller].start_with? "auth"
        end

        def render_404
                raise ActionController::RoutingError.new("Not Found")
        end

end
