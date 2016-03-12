class Api::V1::UsersController < ApplicationController
  def index
	user_list = User.all
	render json: user_list
  end

  def new

  end

  def create
    new_user = User.new
  	new_user.name = params[:name]
  	new_user.facebook_id = params[:facebook_id]
  	new_user.email = params[:email]
  	new_user_school = School.find_by(name: params[:school])
  	new_user.school_id = new_user_school.id
  	new_user.save
  end

  def show
  	render json: User.find(params[:id])
  end

  def edit

  end

  def update
  	 selected_user = User.find(params[:id])
  	 selected_user.name = params[:name]
  	 selected_user.facebook_id = params[:facebook_id]
  	 selected_user.email = params[:email]
  	 selected_user_school = School.find_by(name: params[:school])
  	 selected_user.school_id = selected_user_school.id
  	 selected_user.save
  end

  def destroy
  	 del_entry = User.find(params[:id])
  	 del_entry.destroy
  	 render :json => {:status => "success"}
  end

end