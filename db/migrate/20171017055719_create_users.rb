class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :role, default: :user
      t.string :password_digest
      t.string :avatar
      t.integer :coin

      t.timestamps
    end
  end
end
