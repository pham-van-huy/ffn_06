class SocialAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :social_accounts, force: true do |table|
      table.integer :user_id
      table.string :provider
      table.string :provider_id
    end
  end
end
