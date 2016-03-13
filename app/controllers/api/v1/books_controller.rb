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
    if Category.where(:name => params[:categoryName]).present?
        new_book.category_id = Category.find_by(name: params[:categoryName]).id
    else
        new_book_category = Category.new
        new_book_category.name = params[:categoryName]
        new_book_category.save
        new_book.category_id = new_book_category.id
    end

    user = User.findBy(facebook_id: params[:facebook_id])
    book = user.books.create(name: params[:name], edition: params[:edition], category_id: new_book_category.id)
  	user_books = user.user_books.where(book_id: book.id)
    user_books.status = 1
    user_books.sent = 0
    user_books.returned = 0
    user_books.price_per_hour = params[:price_per_hour]

    #Add the book availabilities now
    book_availabilities_array = JSON.parse(params[:book_availabilities])
    book_availabilities_array.each do |book_availability|
      user_books.book_availabilities.create(users_book_id: user_books.id, date: book_availability.date, hours: book_availability.hours)
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


end
