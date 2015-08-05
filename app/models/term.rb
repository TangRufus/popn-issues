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
#  father     :integer          not null
#  url        :string
#
# Indexes
#
#  index_terms_on_host_and_slug_and_taxonomy  (host,slug,taxonomy) UNIQUE
#

class Term < ActiveRecord::Base
  enum taxonomy: [:category, :post_tag, :post_format]

  after_commit :set_url, on: :create

  has_many :taggings, dependent: :destroy
  has_many :posts, through: :taggings

  def self.taxonomy_num(taxonomy_str)
    taxonomies[taxonomy_str]
  end

  def purge_urls
    urls = [url, "#{url}page/2/", "#{url}page/3/"]
  end

  def tax
    return 'category' if category?
    return 'tag' if post_tag?
    ''
  end

  def set_url
    SetTermUrlJob.perform_later(self)
  end
end
