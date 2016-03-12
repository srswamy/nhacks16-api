class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
	  # Automatically creates primary key Id
      t.string :name
	  t.integer :category_id
	  t.integer :edition

      t.timestamps null: false
    end
  end
end
