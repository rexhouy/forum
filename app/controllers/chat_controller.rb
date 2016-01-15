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
                @chats = Chat.where("created_at > ?", DateTime.now.days_ago(params[:time].to_i)).order(id: :asc).paginate(page: params["page"])
                @title = "聊天历史记录"
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
