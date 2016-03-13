class AddDateAndHoursToRentUserBooksTable < ActiveRecord::Migration
  def change
  	add_column :rent_user_books, :date, :date
  	add_column :rent_user_books, :hours, :string
  end
end
