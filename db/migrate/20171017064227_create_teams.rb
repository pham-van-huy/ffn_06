class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.references :country, index: true, foreign_key: true
      t.string :name
      t.text :description
      t.string :logo

      t.timestamps
    end
  end
end
