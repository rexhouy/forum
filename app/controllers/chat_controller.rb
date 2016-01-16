# -*- coding: utf-8 -*-
class ChatController < ApplicationController

        before_action :set_back_url
        skip_before_action :authenticate_user!, only: [:create, :latest]
        skip_before_action :verify_authenticity_token, only: [:create]

        def index
                render layout: false
        end

        def create
                @chat = Chat.new(chat_params)
                if @chat.save!
                        render plain: "ok"
                else
                        render plain: "failed"
                end
        end

        def latest
                @chats = Chat.order(id: :asc).limit(20)
                respond_to do |format|
                        format.json
                end
        end

        def history
                @time = (params[:time] || 1).to_i
                @chats = Chat.where("created_at > ?", DateTime.now.days_ago(@time)).order(id: :asc).paginate(page: params["page"])
                @title = "聊天历史记录"
                @menus = [
                          { name: "昨天", href: "/chat/history?time=1", class: @time.eql?(1) ? "active" : "" },
                          { name: "一周", href: "/chat/history?time=7", class: @time.eql?(7) ? "active" : "" },
                          { name: "30天", href: "/chat/history?time=30", class: @time.eql?(30) ? "active" : "" }
                         ]
        end

        private
        def chat_params
                params[:chat].permit(:text, :name, :avatar)
        end
        def set_back_url
                @title = "聊天室"
                @back_url = root_url
        end

end
