class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.belongs_to :term, index: true, null: false
      t.belongs_to :post, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
