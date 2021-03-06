# -*- coding: utf-8 -*-
class EnrollsController < ApplicationController

        before_action :authenticate_user!, except: [:new, :create]
        load_and_authorize_resource

        def index
                @enrolls = Enroll.where(topic_id: params[:id]).order(id: :asc).paginate(page: session["page"])
                @back_url = "/topics/#{params[:id]}"
        end

        def show
                @enroll = Enroll.find(params[:id])
                @back_url = "/topics/#{@enroll.topic_id}/enroll"
        end

        def new
                @topic = Topic.find(params[:id])
                @back_url = "/topics/#{params[:id]}"
        end

        # POST /enrolls
        # POST /enrolls.json
        def create
                render_404 if session[:user_tel_check].nil?
                session[:user_tel] = session[:user_tel_check]
                captcha = Captcha.where(tel: session[:user_tel], register_token: params[:captcha])
                return redirect_to "/topics/#{params[:tid]}/new_enroll", notice: "验证码错误" unless captcha.present?
                topic = Topic.find(params[:tid])
                if Enroll.where(tel: session[:user_tel], topic_id: params[:tid]).any?
                        return redirect_to topic_url(params[:tid]), notice: "您已经报过名了！"
                end
                @enroll = Enroll.new()
                @enroll.content = params[:content]
                @enroll.topic = topic
                @enroll.tel = session[:user_tel]
                @enroll.order_id = random_order_id
                if topic.enroll_fee.present? && topic.enroll_fee > 0
                        promotion = topic.enroll_promotion || 0
                        @enroll.fee = topic.enroll_fee - promotion
                end

                if @enroll.save!
                        if topic.enroll_fee.present? && topic.enroll_fee > 0
                                # Redirect to payment page
                                redirect_to payment_redirect_url(@enroll)
                        else
                                redirect_to topic_url(params[:tid]), notice: "报名成功！"
                        end
                end
        end

        def confirm
                enroll = Enroll.find(params[:id])
                enroll.update(status: Enroll.statuses[:confirmed])
                redirect_to "/enrolls/#{enroll.id}"
        end

        private
        def payment_redirect_url(enroll)
                return "/user/enrolls" if enroll.paid? || enroll.confirmed?
                "http://forum.tenhs.com/payment/alipay/redirect?id=#{enroll.id}"
        end

        def random_order_id
                "#{SecureRandom.random_number(10**7).to_s.rjust(7,"0")}-#{SecureRandom.random_number(10**7).to_s.rjust(7,"0")}"
        end

end
