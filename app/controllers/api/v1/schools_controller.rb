class Api::V1::SchoolsController < ApplicationController
  def index
	render json: School.all
  end

  def new

  end

  def create
    new_school = School.new
  	new_school.name = params[:name]
  	new_school.location = params[:location]
  	new_school.save
  	render :json => {:status => "success"}
  end

  def show
  	render json: School.find(params[:id])
  end

  def edit

  end

  def update
  	 selected_school = School.find(params[:id])
  	 selected_school.name = params[:name]
  	 selected_school.location = params[:location]
  	 selected_school.save
  	 render :json => {:status => "success"}
  end

  def destroy
  	 del_entry = School.find(params[:id])
  	 del_entry.destroy
  	 render :json => {:status => "success"}
  end
end