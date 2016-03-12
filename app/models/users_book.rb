class UsersBook < ActiveRecord::Base
	has_many :book_availibilities
	has_many :rent_user_books
	belongs_to :user
	belongs_to :book
end
