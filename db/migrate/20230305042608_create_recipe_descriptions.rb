class CreateRecipeDescriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :recipe_descriptions do |t|
      t.integer :recipe_id, null: false
      t.text :description
      t.timestamps
    end
  end
end
