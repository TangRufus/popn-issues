class AddSubscribeUrgentIssuesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subscribe_urgent_issues, :bool, default: false, null: false
    add_index :users, :subscribe_urgent_issues
  end
end
