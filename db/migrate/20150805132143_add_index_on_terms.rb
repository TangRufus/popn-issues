class AddIndexOnTerms < ActiveRecord::Migration
  def change
    add_index(:terms, [:host, :slug, :taxonomy], unique: true)
  end
end
