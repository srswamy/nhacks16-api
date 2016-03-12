class Api::V1::BooksController < ApplicationController
  def index
	book_list = Book.all
	render json: book_list
  end
end