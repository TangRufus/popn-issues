class KpopnPostToFacebookJob < ActiveJob::Base
  queue_as :low

  def perform(post)
    Facebook::Kpopn.new(post).post_to_page
  end
end
