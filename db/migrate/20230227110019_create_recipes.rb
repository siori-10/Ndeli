class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      t.integer :customer_id, null: false
      t.integer :categoriy_id, null: false
      t.integer :tag_id, null: false
      t.string :dish_name, null: false
      t.text :recipe_description, null: false
      t.string :numder_people, null: false
      t.text :procedure, null: false
      t.boolean :is_draft, null: true, default: false

      t.timestamps
    end
  end
end
