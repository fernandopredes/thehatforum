class AddCategoryToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :category, :string
  end
end
