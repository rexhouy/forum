# -*- coding: utf-8 -*-
require "securerandom"
class Auth::CaptchaController < ApplicationController
        include SimpleCaptcha::ControllerHelpers
        skip_before_action :authenticate_user!

        def index
                return render(text: "该手机号已经注册") if "true".eql?(params[:check_tel]) and tel_exists?  # For registration, check tel existance
                captcha = Captcha.find_by_tel(params[:tel])
                captcha ||= Captcha.new
                captcha.tel = params[:tel]
                captcha.register_token = SecureRandom.random_number(10**6).to_s.rjust(6,"0")
                captcha.register_sent_at = DateTime.current + 10.minutes # Expire in 10 minutes

                session[:user_tel_check] = params[:tel]
                SmsService.new.send_captcha(captcha.register_token, captcha.tel)

                captcha.save!
                render text: "ok".html_safe
        end

        private

        def photo_captcha_valid?
                simple_captcha_valid?
        end

        def tel_exists?
                User.where(tel: params[:tel]).count > 0
        end

end
