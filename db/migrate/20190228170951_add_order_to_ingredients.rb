class AddOrderToIngredients < ActiveRecord::Migration[5.1]
  def change
    add_column :ingredients, :order, :integer
  end
end
