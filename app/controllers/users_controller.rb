# -*- coding: utf-8 -*-
class UsersController < ApplicationController
        before_action :set_user, only: [:show, :edit, :update, :destroy]
        before_action :set_back_url, only: [:show, :new, :edit]
        load_and_authorize_resource

        # GET /users
        # GET /users.json
        def index
                render_404 unless current_user.admin?
                @users = User.paginate(page: session["page"])
                @back_url = root_path
        end

        # GET /users/1
        # GET /users/1.json
        def show
        end

        # GET /users/new
        def new
                @user = User.new
        end

        # GET /users/1/edit
        def edit
        end

        # PATCH/PUT /users/1
        # PATCH/PUT /users/1.json
        def update
                respond_to do |format|
                        if @user.update(user_params)
                                format.html { redirect_to edit_user_path(@user), notice: "更新成功" }
                                format.json { render :show, status: :ok, location: @user }
                        else
                                format.html { render :edit }
                                format.json { render json: @user.errors, status: :unprocessable_entity }
                        end
                end
        end

        # DELETE /users/1
        # DELETE /users/1.json
        def destroy
                @user.update(active: false)
                respond_to do |format|
                        format.html { redirect_to users_url, notice: "\"#{@user.name}\"已成功删除" }
                        format.json { head :no_content }
                end
        end

        private
        # Use callbacks to share common setup or constraints between actions.
        def set_user
                @user = User.find(params[:id])
                render_404 unless current_user.admin? || @user.id.eql?(current_user.id)
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def user_params
                params[:user].permit(:name, :avatar, :active, :role)
        end

        def set_back_url
                @title = "用户"
                @back_url = current_user.admin? ? users_path : root_path
        end
end
