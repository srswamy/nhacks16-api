class RemoveDateTimesFromCategories < ActiveRecord::Migration
  def change
   remove_column :categories, :created_at
   remove_column :categories, :updated_at
  end
end
