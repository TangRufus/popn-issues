class AddSubscribeNewIssueToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subscribe_new_issue, :bool, default: true, null: false
    add_index :users, :subscribe_new_issue
  end
end
