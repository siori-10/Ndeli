class CreateTagRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :tag_recipes do |t|
      t.integer :recipe_id, null: false
      t.integer :tag_id, null: false

      t.timestamps
    end
  end
end
