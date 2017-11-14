class AddDeviseToUsers < ActiveRecord::Migration[5.1]
  def self.up
    change_table :users do |t|
      t.remove :name
      t.remove :password_digest
      t.change :coin, :integer,:default => 0
      t.string :encrypted_password, null: false, default: ""
      t.datetime :remember_created_at
    end
    add_index :users, :email, unique: true
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
