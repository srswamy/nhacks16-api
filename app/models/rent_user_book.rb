class RentUserBook < ActiveRecord::Base
	belongs_to :users_book
	delegate :book, :to => :users_book, :allow_nil => true
end