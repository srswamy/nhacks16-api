class Api::V1::CategoriesController < ApplicationController
  def index
	category_list = Category.all
	render json: category_list
  end
end