module Facebook
  class Apopn < Facebook::Base
    def initialize(post)
      super(message: post.excerpt,
      link: post.link,
      token: Rails.application.secrets.apopn_fb_page_token,
      post: post
      )
    end

    def post_to_page
      if Post.last_posted_to_fb_at > 5.minutes.ago
        return ApopnPostToFacebookJob.set(wait: 1.minute).perform_later(@post)
      else
        super
      end
    end
  end
end
