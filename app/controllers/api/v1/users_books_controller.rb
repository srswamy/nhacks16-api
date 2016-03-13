class Api::V1::UsersBooksController < ApplicationController
skip_before_filter :verify_authenticity_token

  def index
	users_books_list = UsersBook.all
	render json: users_books_list
  end

  def new

  end

  def create
    new_user_book = UsersBook.new
  	new_user_book.user_id = params[:user_id]

    if Book.where(:name => params[:book_name]).present?
      selected_book = Book.find_by(name: params[:book_name])
  	  new_user_book.book_id = selected_book.id
    else
      selected_book = Book.new
      selected_book.name = params[:book_name]
      selected_book.category_id = params[:category_id]
      selected_book.edition = params[:edition]
      selected_book.save
      new_user_book.book_id = selected_book.id
    end

  	new_user_book.status = params[:status]
  	new_user_book.sent = false
  	new_user_book.returned = false
  	new_user_book.price_per_hour = params[:price_per_hour]
  	new_user_book.save

  	new_book_avail = BookAvailability.new
  	new_book_avail.users_book_id = new_user_book.id
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
  	 selected_user_book = UsersBook.find(params[:id])
  	 selected_user_book.user_id = params[:user_id]
     selected_book = Book.find(name: params[:book_name])
     selected_user_book.book_id = selected_book.id
  	 selected_user_book.status = params[:status]
  	 selected_user_book.sent = params[:sent]
     selected_user_book.returned = params[:returned]
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

  def get_book_availabilities
    book_availabilities = BookAvailability.find(params[:id])

    render json: book_availabilities
  end

  def update_book_availability
  	 update_book_availability = BookAvailability.find(params[:id])
  	 update_book_availability.start_availability = params[:start]
  	 update_book_availability.end_availability = params[:end]

  	 render :json => {:status => "success"}
  end

  #Endpoint: http://localhost:3000/api/v1/users/books/owner
  #=Parameters
  #==users_book_id
  #=Returns
  #==A user row
  #{"book_owner":{"id":1,"name":"NV","facebook_id":"10","email":"envybhargava26@gmail.com","school_id":1,"karma":null}}
  def get_book_owner
    book = UsersBook.find(params[:users_book_id])

    render :json => {:book_owner => book.user}
  end


end
