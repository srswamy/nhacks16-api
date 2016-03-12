class FixBooksUserIdColumn < ActiveRecord::Migration
  def change
    rename_column :book_availabilities, :user_book_id, :users_book_id
  end
end
