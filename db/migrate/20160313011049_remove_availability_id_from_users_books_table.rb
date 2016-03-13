class RemoveAvailabilityIdFromUsersBooksTable < ActiveRecord::Migration
  def change
  	remove_column :users_books, :book_availability_id, :integer
  end
end
