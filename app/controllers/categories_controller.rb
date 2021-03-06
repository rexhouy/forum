# -*- coding: utf-8 -*-
class CategoriesController < ApplicationController
        before_action :set_category, only: [:show, :edit, :update, :destroy]
        before_action :set_back_url, only: [:show, :new, :edit]
        before_action :authenticate_user!
        load_and_authorize_resource

        # GET /categories
        # GET /categories.json
        def index
                @categories = Category.all
                @back_url = root_path
        end

        # GET /categories/1
        # GET /categories/1.json
        def show
        end

        # GET /categories/new
        def new
                @category = Category.new
        end

        # GET /categories/1/edit
        def edit
        end

        # POST /categories
        # POST /categories.json
        def create
                @category = Category.new(category_params)

                respond_to do |format|
                        if @category.save
                                format.html { redirect_to categories_url, notice: "创建成功" }
                                format.json { render :show, status: :created, location: @category }
                        else
                                format.html { render :new }
                                format.json { render json: @category.errors, status: :unprocessable_entity }
                        end
                end
        end

        # PATCH/PUT /categories/1
        # PATCH/PUT /categories/1.json
        def update
                respond_to do |format|
                        if @category.update(category_params)
                                format.html { redirect_to categories_url, notice: "更新成功" }
                                format.json { render :show, status: :ok, location: @category }
                        else
                                format.html { render :edit }
                                format.json { render json: @category.errors, status: :unprocessable_entity }
                        end
                end
        end

        # DELETE /categories/1
        # DELETE /categories/1.json
        def destroy
                @category.destroy
                respond_to do |format|
                        format.html { redirect_to categories_url, notice: "删除成功" }
                        format.json { head :no_content }
                end
        end

        private
        # Use callbacks to share common setup or constraints between actions.
        def set_category
                @category = Category.find(params[:id])
        end

        # Never trust parameters from the scary internet, only allow the white list through.
        def category_params
                params[:category].permit(:name)
        end

        def set_back_url
                @title = "板块"
                @back_url = categories_path
        end
end
