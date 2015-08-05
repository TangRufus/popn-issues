class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :slug, null: false
      t.string :host, null: false
      t.integer :type

      t.timestamps null: false
    end
  end
end
