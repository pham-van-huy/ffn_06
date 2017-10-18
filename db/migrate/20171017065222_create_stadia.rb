class CreateStadia < ActiveRecord::Migration[5.1]
  def change
    create_table :stadia do |t|
      t.references :country, index: true, foreign_key: true
      t.string :name
      t.string :adress
      t.text :introduction

      t.timestamps
    end
  end
end
