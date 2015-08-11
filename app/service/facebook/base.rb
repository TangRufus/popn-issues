module Facebook
  class Base
    def initialize(message:, link:, token:, post:)
      @message = message
      @link = link
      @client = Koala::Facebook::API.new(token)
      @post = post
    end

    def post_to_page
      return if Post.last_posted_to_fb_at > 3.minutes.ago
      return unless @post.should_post_to_facebook?

      response = @client.put_connections('me', 'feed', message: @message, link: @link)

      @post.update(posted_to_fb_at: Time.zone.now) if response['id']
    end
  end
end
