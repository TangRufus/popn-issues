class RenameColumnTypeInTermsToTaxonomy < ActiveRecord::Migration
  def change
    rename_column :terms, :type, :taxonomy
  end
end
