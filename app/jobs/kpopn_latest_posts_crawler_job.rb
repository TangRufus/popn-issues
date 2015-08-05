class KpopnLatestPostsCrawlerJob < ActiveJob::Base
  queue_as :crawler

  def perform
    Wordpress::Kpopn.new.crawl_latest_posts
  end
end
