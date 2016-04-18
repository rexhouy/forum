# -*- coding: utf-8 -*-
class ChatController < ApplicationController

        # before_action :authenticate_topic, only: [:latest, :history, :save]
        skip_before_action :verify_authenticity_token, only: [:create]

        def index
                @enroll = Enroll.find(params[:enroll_id])
                render_404 unless @enroll.joined?(session[:user_tel])
                set_back_url
                render layout: false
        end

        def create
                @chat = Chat.new(chat_params)
                @chat.topic_id = params[:topic_id]
                if @chat.save!
                        render plain: "ok"
                else
                        render plain: "failed"
                end
        end

        def latest
                @chats = Chat.where(topic_id: params[:topic_id]).order(id: :asc).limit(20)
                respond_to do |format|
                        format.json
                end
        end

        def history
                authenticate_topic
                @topic_id = params[:topic_id]
                @time = (params[:time] || 1).to_i
                @chats = Chat.where(topic_id: params[:topic_id]).where("created_at > ?", DateTime.current.days_ago(@time)).order(id: :asc).paginate(page: params["page"])
                @title = "聊天历史记录"
                @menus = [
                          { name: "昨天", href: "/chat/#{@topic_id}/history?time=1", class: @time.eql?(1) ? "active" : "" },
                          { name: "一周", href: "/chat/#{@topic_id}/history?time=7", class: @time.eql?(7) ? "active" : "" },
                          { name: "30天", href: "/chat/#{@topic_id}/history?time=30", class: @time.eql?(30) ? "active" : "" }
                         ]
        end

        private
        def authenticate_topic
                enroll = Enroll.where(user_id: current_user.id, topic_id: params[:topic_id]).first
                render_404 if enroll.nil? || !enroll.joined?(current_user)
        end
        def chat_params
                params[:chat].permit(:text, :name, :avatar)
        end
        def set_back_url
                @title = "聊天室"
                @back_url = "/topics/#{@enroll.topic_id}"
        end

end
