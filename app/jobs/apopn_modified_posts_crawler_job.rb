class ApopnModifiedPostsCrawlerJob < ActiveJob::Base
  queue_as :crawler

  def perform
    Wordpress::Apopn.new.crawl_modified_posts
  end
end
