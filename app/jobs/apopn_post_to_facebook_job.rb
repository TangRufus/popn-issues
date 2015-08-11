class ApopnPostToFacebookJob < ActiveJob::Base
  queue_as :low

  def perform(post:)
    Facebook::Apopn.new(post: post).post_to_page
  end
end
