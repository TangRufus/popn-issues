class AddFatherToTerms < ActiveRecord::Migration
  def change
    add_column :terms, :father, :integer, null: false
  end
end
