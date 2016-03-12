class Api::V1::CategoriesController < ApplicationController
  def index
	category_list = Category.all
	render json: category_list
  end

  def new

  end

  def create
    new_category = Category.new
  	new_category.name = params[:name]
  	new_category.save
  	render :json => {:status => "success"}
  end

  def show
  	render json: Category.find(params[:id])
  end

  def edit

  end

  def update
  	 selected_category = Category.find(params[:id])
  	 selected_category.name = params[:name]
  	 selected_category.save
  	 render :json => {:status => "success"}
  end

  def destroy
  	 del_entry = Category.find(params[:id])
  	 del_entry.destroy
  	 render :json => {:status => "success"}
  end

end