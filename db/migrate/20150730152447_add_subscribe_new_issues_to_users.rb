class AddSubscribeNewIssuesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subscribe_new_issues, :bool, default: true, null: false
    add_index :users, :subscribe_new_issues
  end
end
