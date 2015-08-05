class AddUrlToTerms < ActiveRecord::Migration
  def change
    add_column :terms, :url, :string
  end
end
