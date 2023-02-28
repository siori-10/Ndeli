class CreateMaterialRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :material_recipes do |t|
      t.integer :recipe_id, null: false
      t.string :amount_material, null: false

      t.timestamps
    end
  end
end
