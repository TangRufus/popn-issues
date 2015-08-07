module Facebook
  class Base
    def initialize(message:, link:, token:, post:)
      @message = message
      @link = link
      @client = Koala::Facebook::API.new(token)
      @post = post
    end

    def post_to_page
      return unless @post.should_post_to_facebook?

      @client.put_connections('me', 'feed', message: @message, link: @link)
      @post.posted_to_fb_at = Time.zone.now
      @post.save!
    end
  end
end
