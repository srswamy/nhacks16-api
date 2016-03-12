class User < ActiveRecord::Base
	has_many :rent_user_books
	has_many :users_books
	has_many :books, :through => :users_books
	belongs_to :school
end