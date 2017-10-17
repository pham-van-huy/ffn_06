class CreateNews < ActiveRecord::Migration[5.1]
  def change
    create_table :news do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.text :content
      t.integer :count_comment
      t.string :represent_image

      t.timestamps
    end
  end
end
