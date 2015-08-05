class KpopnLatestPostsCrawler
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  sidekiq_options queue: :low

  recurrence backfill: true do
    minutely(5)
  end

  def perform(last_occurrence, current_occurrence)
    Wordpress::Kpopn.new.crawl_latest_posts
  end
end
