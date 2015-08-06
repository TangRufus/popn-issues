class AddPurgedAtToTerms < ActiveRecord::Migration
  def change
    add_column :terms, :purged_at, :datetime
  end
end
