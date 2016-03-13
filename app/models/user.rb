class User < ActiveRecord::Base
	has_many :rent_user_books
	has_many :users_books
	has_many :books, :through => :users_books
	belongs_to :school
	has_many :book_availabilities, -> { select 'book_availabilities.*, users_books.status as current_status' }, :through => :users_books
end