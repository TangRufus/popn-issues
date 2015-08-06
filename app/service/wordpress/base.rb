module Wordpress
  class Base
    def initialize(host:, username:, password:)
      @host = host
      @client = Rubypress::Client.new(host: host, username: username, password: password)
    end

    def crawl_latest_posts
      save_posts latest_posts
    end

    def crawl_modified_posts
      save_posts modified_posts
    end

    def latest_posts
      @client.getPosts(filter: latest_posts_filter)
    end

    def modified_posts
      @client.getPosts(filter: modified_posts_filter)
    end

    def set_term_url(term)
      url = "http://#{@host}/#{term.tax}/"
      unless term.father.zero?
        url += @client.getTerm(term_id: term.father, taxonomy: term.taxonomy)['slug']
        url += '/'
      end
      url += term.slug
      url += '/'
      term.update(url: url)
    end

    private

    def save_posts(posts)
      posts.reverse_each do |p|
        post = save_post(p)
        terms = p['terms'].collect { |t| save_term(t) }
        post.terms << terms
        post.save!
      end
    end

    def save_post(post_attrs)
      attributes = {
        title: post_attrs['post_title'],
        published_at: Time.zone.local(*post_attrs['post_date'].to_a),
        modified_at: Time.zone.local(*post_attrs['post_modified'].to_a),
        link: post_attrs['link'],
        excerpt: post_attrs['post_excerpt'],
        host: @host
      }
      post = Post.where(link: post_attrs['link']).first_or_initialize
      post.update(attributes)
      post
    end

    def save_term(term_attrs)
      taxonomy = Term.taxonomy_num(term_attrs['taxonomy'])
      attributes = {
        host: @host,
        slug: term_attrs['slug'],
        taxonomy: taxonomy,
        father: term_attrs['parent']
      }
      term = Term.where(attributes).first_or_create!
      PurgeCloudflareJob.perform_later(term)
      term
    end

    def latest_posts_filter
      { post_type: 'post', post_status: 'publish', number: 20, 'order': 'DESC' }
    end

    def modified_posts_filter
      { post_type: 'post', post_status: 'publish', number: 20, orderby: 'modified', order: 'DESC' }
    end
  end
end
