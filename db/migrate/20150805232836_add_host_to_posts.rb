class AddHostToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :host, :string, null: false
    add_index :posts, :host
  end
end
