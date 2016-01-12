# -*- coding: utf-8 -*-
class ChatController < ApplicationController

        before_action :set_back_url

        def index
                render layout: false
        end

        private
        def set_back_url
                @title = "聊天室"
                @back_url = root_url
        end

end
