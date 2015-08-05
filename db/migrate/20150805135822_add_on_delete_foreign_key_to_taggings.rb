class AddOnDeleteForeignKeyToTaggings < ActiveRecord::Migration
  def change
    remove_foreign_key :taggings, :posts
    add_foreign_key :taggings, :posts, on_delete: :cascade
  end
end
