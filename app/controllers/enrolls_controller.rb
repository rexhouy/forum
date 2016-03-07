# -*- coding: utf-8 -*-
class EnrollsController < ApplicationController

        before_action :authenticate_user!
        load_and_authorize_resource

        def index
                @enrolls = Enroll.where(topic_id: params[:id]).order(id: :asc).paginate(page: session["page"])
                @back_url = "/topics/#{params[:id]}"
        end

        def show
                @enroll = Enroll.find(params[:id])
                questions = Question.where(topic_id: @enroll.topic_id)
                @questions = {}
                questions.each do |question|
                        @questions[question.id] = question.content
                end
                @back_url = "/topics/#{@enroll.topic_id}/enroll"
        end

        # POST /enrolls
        # POST /enrolls.json
        def create
                @enroll = Enroll.new()
                @enroll.content = params[:content]
                @enroll.topic_id = params[:tid]
                @enroll.user_id = current_user.id

                if @enroll.save
                        redirect_to topic_url(params[:tid]), notice: "报名成功！"
                end
        end

        private

end
