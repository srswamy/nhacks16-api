class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
	  t.string :name
	  t.string :facebook_id
	  t.string :email
	  t.integer :school_id
    end
  end
end
