class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.integer :team1_id
      t.integer :team2_id
      t.references :stadium, index: true, foreign_key: true
      t.references :league, index: true, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.integer :team1_goal
      t.integer :team2_goal

      t.timestamps
    end
  end
end
