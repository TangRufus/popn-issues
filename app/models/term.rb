# == Schema Information
#
# Table name: terms
#
#  id         :integer          not null, primary key
#  slug       :string           not null
#  host       :string           not null
#  taxonomy   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_terms_on_host_and_slug_and_taxonomy  (host,slug,taxonomy) UNIQUE
#

class Term < ActiveRecord::Base
  enum taxonomies: [:category, :post_tag, :post_format]

  has_many :taggings, dependent: :destroy
  has_many :posts, through: :taggings
end
