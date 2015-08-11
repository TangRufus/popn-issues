class PostToFacebookJob < ActiveJob::Base
  queue_as :default

  def perform
    post = Post.facebook_queue.first
    return unless post

    if post.host == 'apopn.com'
      ApopnPostToFacebookJob.perform_later(post: post)
    elsif post.host == 'kpopn.com'
      KpopnPostToFacebookJob.perform_later(post: post)
    end
  end
end
