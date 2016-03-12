class AddDetailsToUsersBooks < ActiveRecord::Migration
  def change
    add_column :users_books, :sent, :boolean
    add_column :users_books, :returned, :boolean
    add_column :users_books, :price_per_hour, :decimal
  end
end
