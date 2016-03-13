class RemoveDateTimesFromBookAvailabilitiesTable < ActiveRecord::Migration
  def change
  	remove_column :book_availabilities, :start_availability, :datetime
  	remove_column :book_availabilities, :end_availability, :datetime
  end
end
