class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.belongs_to :user, null: false

      t.timestamps null: false
    end
    add_index :wikis, :title, unique: true
    add_index :wikis, :user_id
  end
end
