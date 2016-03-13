class ModifyNameDataTypeInCategories < ActiveRecord::Migration
  def change
	change_column :categories, :name, :string
  end
end
