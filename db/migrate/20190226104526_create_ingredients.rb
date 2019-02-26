class CreateIngredients < ActiveRecord::Migration[5.1]
  def change
    create_table :ingredients do |t|
      t.string :name
      t.float :quantity
      t.string :unit
      t.references :recipe, foreign_key: true
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
