class RenameUserBooksToUsersBooks < ActiveRecord::Migration
  def change
    rename_table :user_books, :users_books
  end
end
