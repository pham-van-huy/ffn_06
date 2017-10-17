class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.references :team, index: true, foreign_key: true
      t.references :country, index: true, foreign_key: true
      t.string :name
      t.datetime :birthday
      t.string :avatar
      t.text :introduction

      t.timestamps
    end
  end
end
