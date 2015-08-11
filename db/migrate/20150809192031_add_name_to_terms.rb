class AddNameToTerms < ActiveRecord::Migration
  def change
    add_column :terms, :name, :string
  end
end
