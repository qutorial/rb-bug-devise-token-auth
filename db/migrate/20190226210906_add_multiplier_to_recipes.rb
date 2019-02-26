class AddMultiplierToRecipes < ActiveRecord::Migration[5.1]
  def change
    add_column :recipes, :multiplier, :float
  end
end
