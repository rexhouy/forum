class ApplicationController < ActionController::Base
        # Prevent CSRF attacks by raising an exception.
        # For APIs, you may want to use :null_session instead.
        protect_from_forgery with: :exception
        include CanCan::ControllerAdditions
        skip_before_action :verify_authenticity_token, if: :skip_forgery_protection?

        WillPaginate.per_page = 20

        # before_action :authenticate_user!

        def render_404
                raise ActionController::RoutingError.new("Not Found")
        end

        before_action :configure_permitted_parameters, if: :devise_controller?
        protected
        def configure_permitted_parameters
                devise_parameter_sanitizer.for(:sign_up) << :name
        end

        private
        def skip_forgery_protection?
                [
                 {controller: "payments", action: "wechat_notify"},
                 {controller: "payments", action: "alipay_notify"}
                ].any? do |p|
                        params[:controller].eql? p[:controller] and action_name.eql? p[:action]
                end
        end


end
