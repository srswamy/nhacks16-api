class RemoveDateTimesFromSchools < ActiveRecord::Migration
  def change
   remove_column :schools, :created_at
   remove_column :schools, :updated_at
  end
end
