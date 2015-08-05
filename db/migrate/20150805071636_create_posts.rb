class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :title, null: false
      t.timestamp :published_at, null: false
      t.timestamp :modified_at, null: false
      t.string :link, null: false
      t.text :excerpt

      t.timestamps null: false
    end
    add_index :posts, :published_at
    add_index :posts, :modified_at
    add_index :posts, :link, unique: true
  end
end
