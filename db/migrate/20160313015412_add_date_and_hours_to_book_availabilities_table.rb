class AddDateAndHoursToBookAvailabilitiesTable < ActiveRecord::Migration
  def change
  	add_column :book_availabilities, :date, :date
  	add_column :book_availabilities, :hours, :string
  end
end
