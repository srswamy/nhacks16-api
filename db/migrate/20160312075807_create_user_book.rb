class CreateUserBook < ActiveRecord::Migration
  def change
    create_table :user_books do |t|
	  t.integer :user_id
	  t.integer :book_id
	  t.boolean :status
	  t.integer :book_availability_id
    end
  end
end
