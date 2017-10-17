class CreateCountries < ActiveRecord::Migration[5.1]
  def change
    create_table :countries do |t|
      t.references :continent, index: true, foreign_key: true
      t.string :name
      t.string :logo

      t.timestamps
    end
  end
end
