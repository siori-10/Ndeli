class CreateMaterials < ActiveRecord::Migration[6.1]
  def change
    create_table :materials do |t|
      t.integer :customer_id, null: false
      t.integer :recipe_id, null: false
      t.string :material_name

      t.timestamps
    end
  end
end
