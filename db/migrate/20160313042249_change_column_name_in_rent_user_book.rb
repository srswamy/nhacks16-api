class ChangeColumnNameInRentUserBook < ActiveRecord::Migration
  def change
	rename_column :rent_user_books, :user_book_id, :users_book_id
  end
end
