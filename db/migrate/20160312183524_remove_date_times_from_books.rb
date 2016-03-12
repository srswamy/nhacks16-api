class RemoveDateTimesFromBooks < ActiveRecord::Migration
  def change
    remove_column :books, :created_at
	remove_column :books, :updated_at
  end
end
