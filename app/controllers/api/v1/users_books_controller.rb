class Api::V1::UsersBooksController < ApplicationController
  def index
	users_books_list = Users_Book.all
	render json: users_books_list
  end

  def new

  end

  def create
    new_user_book = Users_Book.new
  	new_user_book.user_id = params[:user_id]
  	selected_book = Book.find(name: params[:book_name])
  	new_user_book.book_id = selected_book.id
  	new_user_book.status = params[:status]
  	new_user_book.save

  	new_book_avail = Book_Availability.new
  	new_book_avail.user_book_id = new_user_book.id
  	new_book_avail.start_availability = params[:start]
  	new_book_avail.end_availability = params[:end]
  	new_book_avail.save

  	user_book = Users_Book.find(new_user_book.id)
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

  # Update the status for a particular User_Book entry
  def update_status
  	  update_user_book = Users_Book.find(params[:id])
  	  update_user_book.status = params[:status]

  	  render :json => {:status => "success"}
  end

end