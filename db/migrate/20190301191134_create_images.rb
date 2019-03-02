class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.references :recipe, foreign_key: true
      t.string :filename

      t.timestamps
    end
  end
end
