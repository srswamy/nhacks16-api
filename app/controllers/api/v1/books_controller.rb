class Api::V1::BooksController < ApplicationController
skip_before_filter :verify_authenticity_token

  def index
	book_list = Book.all
	render json: book_list
  end

  def new

  end

  #Returns a status if successful
  # *Args*
  # => +category_name+ -> the category name of the book
  # => +facebook_id+ -> facebook ID of the user
  # => +name+ -> name of the book
  # => +edition+ -> edition of the book
  # => +price_per_hour+ -> price per hour for the book
  # => +book_availabilities+ -> an array of JSON with the book_availability times as follows:
  # => -> "book_availabilities": [{date: "2012-02-02", hours: "2,4,5,7"}, {date: "2012-02-23", hours: "3,4,6,7"}]
  def create
    new_book_category_id = Category.find_by(name: params[:category_name]).id    
    user = User.find(params[:user_id])

    if Book.where(:name => params[:name]).present?
      book = Book.find_by(name: params[:name])
    else
      book = user.books.create(name: params[:name], edition: params[:edition], category_id: new_book_category_id)
    end

  	user_books = user.users_books.where(book_id: book.id).first
    user_books.status = true
    user_books.sent = false
    user_books.returned = false
    user_books.price_per_hour = params[:price_per_hour]
    user_books.save

    #Add the book availabilities now
    book_availabilities_array = JSON.parse(params[:book_availabilities])
    book_availabilities_array.each do |book_availability|
      user_books.book_availabilities.create(users_book_id: user_books.id, date: book_availability["date"].to_date, hours: book_availability["hours"].join(",").to_str)
    end

    render :json => {:status => "success"}
  end

  def show
  	render json: Book.find(params[:id])
  end

  def edit

  end

  def update
  	 selected_book = Book.find(params[:id])
  	 selected_book.name = params[:name]
  	 selected_book_category = Category.findBy(name: params[:categoryName])
  	 selected_book.category_id = selected_book_category.id
  	 selected_book.edition = params[:edition]
  	 selected_book.save
  	 render :json => {:status => "success"}
  end

  def destroy
  	 del_entry = Book.find(params[:id])
  	 del_entry.destroy
  	 render :json => {:status => "success"}
  end


  #=Endpoint: http://localhost:3000/api/v1/books/available
  #=Parameters:
  #==user_id
  #=Returns
  #An array of available books, along with the user_book_id
  #The user_book_id is required to retrieve a particular user-book combination
  #=={"available_books":[{"book":{"id":4,"name":"testt","category_id":1,"edition":5},"user_book_id":3}]}

  def get_available_books
    user = User.find(params[:user_id])
    json_array = Array.new
    UsersBook.all.where(status: 1).where.not(user_id: user.id).find_each do |users_book|
      json_obj = Hash.new
      book = users_book.book
      user_book_id = users_book.id
      json_obj["book"] = book
      json_obj["user_book_id"] = user_book_id
      json_array.push(json_obj)
    end

    render :json => {:available_books => json_array}
  end


end
