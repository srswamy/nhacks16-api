class Book < ActiveRecord::Base
	has_and_belongs_to_many :users
	belongs_to :category
	has_many :users_books
	has_many :users, :through => :users_books
	has_many :book_availabilities, :through => :users_books
end
