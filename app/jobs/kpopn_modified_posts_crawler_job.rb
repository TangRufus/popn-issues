class KpopnModifiedPostsCrawlerJob < ActiveJob::Base
  queue_as :crawler

  def perform
    Wordpress::Kpopn.new.crawl_modified_posts
  end
end
