class AddPostedToFbAtToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :posted_to_fb_at, :datetime
  end
end
