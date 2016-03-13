class Api::V1::BooksController < ApplicationController
skip_before_filter :verify_authenticity_token

  def index
	book_list = Book.all
	render json: book_list
  end

  def new

  end

  def create
    new_book = Book.new
  	new_book.name = params[:name]
  	new_book_category = Category.findBy(name: params[:categoryName])
  	new_book.category_id = new_book_category.id
  	new_book.edition = params[:edition]
  	new_book.save
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
