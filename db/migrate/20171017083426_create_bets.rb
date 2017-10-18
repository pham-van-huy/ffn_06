class CreateBets < ActiveRecord::Migration[5.1]
  def change
    create_table :bets do |t|
      t.references :user, index: true, foreign_key: true
      t.references :match, index: true, foreign_key: true
      t.integer :team1_goal
      t.integer :team2_goal
      t.integer :coin
      t.boolean :result

      t.timestamps
    end
  end
end
