class ApopnLatestPostsCrawlerJob < ActiveJob::Base
  queue_as :crawler

  def perform
    Wordpress::Apopn.new.crawl_latest_posts
  end
end
