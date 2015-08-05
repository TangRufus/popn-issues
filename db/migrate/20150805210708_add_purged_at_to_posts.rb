class AddPurgedAtToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :purged_at, :datetime
  end
end
