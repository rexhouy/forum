# -*- coding: utf-8 -*-
class TopicsController < ApplicationController
        before_action :set_topic, only: [:edit, :update, :destroy]
        before_action :authenticate_user!, except: [:index, :show, :activities]
        load_and_authorize_resource

        # GET /topics
        # GET /topics.json
        def index
                categories = Category.all
                # Save param info, used in back button
                session["category"] = params[:category] if params[:category].present?
                session["category"] = categories[0].id if categories.any? && session["category"].nil?
                session["page"] = params[:page] if params[:page].present?
                @topics = Topic.where(category_id: session["category"]).order(priority: :desc, id: :desc).paginate(page: session["page"])
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
                @topic = Topic.find(params[:id])
                if @topic.enroll && session[:user_tel].present?
                        @user_enroll_info = Enroll.where(tel: session[:user_tel], topic_id: @topic.id).first
                end
                create_access_log
                set_back_url
                render :activity_detail if @topic.enroll
        end

        # GET /topics/new
        def new
                @topic = Topic.new
                set_back_url
                render :new_activity if current_user.partener?
        end

        # GET /topics/1/edit
        def edit
                @back_url = topic_path(@topic)
                render :edit_activity if current_user.partener?
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
                                format.html {
                                        render :new if current_user.admin?
                                        render :new_activity if current_user.partener?
                                }
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

        # POST /topics/1/like.json
        def like
                fav = UserFavorite.where(user_id: current_user.id, topic_id: params[:id])
                if fav.present?
                        render plain: "marked_before"
                else
                        fav = UserFavorite.new
                        fav.user_id = current_user.id
                        fav.topic_id = params[:id]
                        fav.save!
                        render plain: "marked"
                end
        end

        # GET /topics/search
        def search
                @search_text = params[:search_text]
                @topics = Topic.search(@search_text)
                @back_url = topics_url
        end

        def activities
                @activities = Topic.where(category_id: nil).order(priority: :desc, id: :desc).paginate(page: session["page"])
        end

        private
        # Use callbacks to share common setup or constraints between actions.
        def set_topic
                @topic = Topic.find(params[:id])
                render_404 if current_user.user? && !@topic.user_id.eql?(current_user.id)
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def topic_params
                params[:topic].permit(:title, :category_id, :content, :priority, :enroll, :enroll_fee, :enroll_promotion, :desc, :cover_image,
                                      :enroll_start_date, :enroll_end_date, :datetime, :start_time, :location, :min_places, :max_places,
                                      questions_attributes: [:id, :content, :required])
        end

        def set_back_url
                if @topic.present? && @topic.category_id.nil?
                        @back_url = "/activities"
                else
                        @back_url = topics_path
                end
        end

        def create_access_log
                access_log = AccessLog.new
                access_log.resource_name = :topic
                access_log.resource_id = params[:id]
                access_log.user_id = current_user.id if current_user.present?
                access_log.save!
        end
end
