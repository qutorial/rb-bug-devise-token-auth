class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :preparation
      t.string :image
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
