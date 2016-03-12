class Api::V1::UsersBooksController < ApplicationController
  def index
	users_books_list = UsersBook.all
	render json: users_books_list
  end

  def new

  end

  def create
    new_user_book = UsersBook.new
  	new_user_book.user_id = params[:user_id]
  	selected_book = Book.find(name: params[:book_name])
  	new_user_book.book_id = selected_book.id
  	new_user_book.status = params[:status]
  	new_user_book.sent = false
  	new_user_book.returned = false
  	new_user_book.price_per_hour = params[:price_per_hour]
  	new_user_book.save

  	new_book_avail = BookAvailability.new
  	new_book_avail.user_book_id = new_user_book.id
  	new_book_avail.start_availability = params[:start]
  	new_book_avail.end_availability = params[:end]
  	new_book_avail.save

  	user_book = UsersBook.find(new_user_book.id)
  	user_book.book_availability_id = new_book_avail.id
  	user_book.save

  	render :json => {:status => "success"}
  end

  def show
  	render json: User.find(params[:id])
  end

  def edit

  end

  def update
  	 selected_user_book = User.find(params[:id])
  	 selected_user_book.name = params[:name]
  	 selected_user_book.facebook_id = params[:facebook_id]
  	 selected_user_book.email = params[:email]
  	 selected_user_book_school = School.find_by(name: params[:school])
  	 selected_user_book.school_id = selected_user_book_school.id
  	 selected_user_book.save
  	 render :json => {:status => "success"}
  end

  def destroy
  	 del_entry = User.find(params[:id])
  	 del_entry.destroy

  	 render :json => {:status => "success"}
  end

  # Update the status for a particular User_Book entry
  def update_status
  	  update_user_book = UsersBook.find(params[:id])
  	  update_user_book.status = params[:status]

  	  render :json => {:status => "success"}
  end

  # Update the sent flag for a particular User_Book entry
  def update_sent
  	update_user_book = UsersBook.find(params[:id])
  	update_user_book.returned = params[:returned]

  	render :json => {:status => "success"}
  end

  # Update the returned flag for a particular User_Book entry
  def update_returned
  	update_user_book = UsersBook.find(params[:id])
  	update_user_book.returned = params[:returned]

  	render :json => {:status => "success"}
  end

  def update_book_availability
  	 update_book_availability = BookAvailability.find(params[:id])
  	 update_book_availability.start_availability = params[:start]
  	 update_book_availability.end_availability = params[:end]

  	 render :json => {:status => "success"}
  end


end