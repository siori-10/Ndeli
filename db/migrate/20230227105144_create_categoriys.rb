class CreateCategoriys < ActiveRecord::Migration[6.1]
  def change
    create_table :categoriys do |t|
      t.string :categoriy_name

      t.timestamps
    end
  end
end
