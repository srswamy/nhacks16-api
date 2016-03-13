class RemoveDateTimesFromRentUserBooksTable < ActiveRecord::Migration
  def change
  	remove_column :rent_user_books, :start_time, :datetime
  	remove_column :rent_user_books, :end_time, :datetime
  end
end
