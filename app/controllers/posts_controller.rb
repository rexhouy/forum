# -*- coding: utf-8 -*-
class PostsController < ApplicationController
        before_action :set_post, only: [:destroy]

        # GET /posts
        # GET /posts.json
        def index
                @posts = Post.paginate(page: params["page"])
                render layout: false
        end

        # POST /posts
        # POST /posts.json
        def create
                @topic = Topic.find(params[:topic_id])
                return render 404 unless @topic.present?
                @post = @topic.posts.new(post_params)
                @post.user = current_user

                respond_to do |format|
                        if @post.save!
                                format.html { redirect_to @topic, notice: "创建成功" }
                                format.json { render :show, status: :created, location: @post }
                        else
                                format.html { redirect_to @topic, notice: "创建成功" }
                                format.json { render json: @post.errors, status: :unprocessable_entity }
                        end
                end
        end

        # DELETE /posts/1
        # DELETE /posts/1.json
        def destroy
                @post.destroy
                respond_to do |format|
                        format.html { redirect_to posts_url, notice: "\"#{@post.title}\"已成功删除" }
                        format.json { head :no_content }
                end
        end

        private
        # Use callbacks to share common setup or constraints between actions.
        def set_post
                @post = Post.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def post_params
                params.require(:post).permit(:content)
        end

end
