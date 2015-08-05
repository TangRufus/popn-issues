module Wordpress
  class Apopn < Wordpress::Base
    def initialize
    super(host: 'apopn.com',
          username: Rails.application.secrets.apopn_username,
          password: Rails.application.secrets.apopn_password)
    end
  end
end
