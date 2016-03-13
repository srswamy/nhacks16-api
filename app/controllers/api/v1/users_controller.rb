class Api::V1::UsersController < ApplicationController
skip_before_filter :verify_authenticity_token

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
	if School.where(:name => params[:school]).present?
		new_user.school_id = School.find_by(name: params[:school]).id
	else 
		new_user_school = School.new
		new_user_school.name = params[:school]
		new_user_school.location = params[:location]
		new_user_school.save
		new_user.school_id = new_user_school.id
	end
  	new_user.save
  	render :json => {:status => "success", :user_id => new_user.id}
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
  	 render :json => {:status => "success"}
  end

  def destroy
  	 del_entry = User.find(params[:id])
  	 del_entry.destroy
  	 render :json => {:status => "success"}
  end


  #Takes in a facebook ID as an argument and returns all the lent books, with their status
  #(0 being not currently available, and 1 being currently available)
  #*Args*
  #facebook_id -> facebook_id of the user
  #*Returns*
  #=books -> a JSON array of the lent books
  #=={"books":[{"current_status":0,"book":{"id":1,"name":"Introduction to databases","category_id":1,"edition":4}},{"current_status":0,"book":{"id":1,"name":"Introduction to databases","category_id":1,"edition":4}},{"current_status":1,"book":{"id":2,"name":"Intro to something","category_id":1,"edition":2}}]}
  def get_lent_books
    user = User.find_by(facebook_id: params[:user_id])
    book_availabilities = user.book_availabilities
    json_array = Array.new
    book_availabilities.each do |availability|
      current_json_obj = Hash.new
      current_status = availability.current_status
      book = availability.book
      current_json_obj["current_status"] = current_status
      current_json_obj["book"] = book
      json_array.push(current_json_obj)
    end

    render :json => {:books => JSON.generate(json_array)}
  end


end
