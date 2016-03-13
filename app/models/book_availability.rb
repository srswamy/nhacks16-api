class BookAvailability < ActiveRecord::Base
	self.table_name = "book_availabilities"
	belongs_to :users_book
	#has_one :book, :through => :users_books
	delegate :book, :to => :users_book, :allow_nil => true
end