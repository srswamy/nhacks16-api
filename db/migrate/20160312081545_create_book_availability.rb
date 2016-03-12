class CreateBookAvailability < ActiveRecord::Migration
  def change
    create_table :book_availabilities do |t|
	  t.integer :user_book_id
	  t.datetime :start_availability
	  t.datetime :end_availability 
    end
  end
end
