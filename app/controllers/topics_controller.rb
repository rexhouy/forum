# -*- coding: utf-8 -*-
class TopicsController < ApplicationController
        before_action :set_topic, only: [:show, :edit, :update, :destroy]
        before_action :set_back_url, only: [:show, :new]

        # GET /topics
        # GET /topics.json
        def index
                categories = Category.all
                # Save param info, used in back button
                session["category"] = params[:category] if params[:category].present?
                session["category"] = categories[0].id if categories.any? && session["category"].nil?
                session["page"] = params[:page] if params[:page].present?
                @topics = Topic.where(category_id: session["category"]).paginate(page: session["page"])
                @menus = []
                categories.each do |c|
                        @menus << {
                                name: c.name,
                                href: "#{topics_url}?category=#{c.id}",
                                class: c.id.eql?(session[:category].to_i) ? "active" : ""
                        }
                end
        end

        # GET /topics/1
        # GET /topics/1.json
        def show
        end

        # GET /topics/new
        def new
                @topic = Topic.new
        end

        # GET /topics/1/edit
        def edit
                @back_url = topic_path(@topic)
        end

        # POST /topics
        # POST /topics.json
        def create
                @topic = Topic.new(topic_params)
                @topic.user = current_user

                respond_to do |format|
                        if @topic.save
                                format.html { redirect_to @topic, notice: "创建成功" }
                                format.json { render :show, status: :created, location: @topic }
                        else
                                format.html { render :new }
                                format.json { render json: @topic.errors, status: :unprocessable_entity }
                        end
                end
        end

        # PATCH/PUT /topics/1
        # PATCH/PUT /topics/1.json
        def update
                respond_to do |format|
                        if @topic.update(topic_params)
                                format.html { redirect_to @topic, notice: "更新成功" }
                                format.json { render :show, status: :ok, location: @topic }
                        else
                                format.html { render :edit }
                                format.json { render json: @topic.errors, status: :unprocessable_entity }
                        end
                end
        end

        # DELETE /topics/1
        # DELETE /topics/1.json
        def destroy
                @topic.destroy
                respond_to do |format|
                        format.html { redirect_to topics_url, notice: "\"#{@topic.title}\"已成功删除" }
                        format.json { head :no_content }
                end
        end

        private
        # Use callbacks to share common setup or constraints between actions.
        def set_topic
                @topic = Topic.find(params[:id])
                render_404 unless @topic.user_id.eql? current_user.id
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def topic_params
                params[:topic].permit(:title, :category_id, :content)
        end

        def set_back_url
                @back_url = topics_path
        end
end
