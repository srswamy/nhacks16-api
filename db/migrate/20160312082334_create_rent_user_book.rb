class CreateRentUserBook < ActiveRecord::Migration
  def change
    create_table :rent_user_books do |t|
	  t.integer :user_book_id
	  t.integer :rentee_id
	  t.datetime :start_time
	  t.datetime :end_time
    end
  end
end
