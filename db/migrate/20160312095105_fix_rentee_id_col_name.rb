class FixRenteeIdColName < ActiveRecord::Migration
  def change
    rename_column :rent_user_books, :rentee_id, :user_id
  end
end
