class Api::V1::SchoolsController < ApplicationController
  def index
	user_list = School.all
	render json: user_list
  end
end