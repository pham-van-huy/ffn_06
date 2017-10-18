class CreateLeagues < ActiveRecord::Migration[5.1]
  def change
    create_table :leagues do |t|
      t.references :country, index: true, foreign_key: true
      t.references :continent, index:  true, foreign_key: true
      t.string :name
      t.date :time
      t.string :logo
      t.text :introduction

      t.timestamps
    end
  end
end
