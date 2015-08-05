module Wordpress
  class Kpopn < Wordpress::Base
    def initialize
    super(host: 'kpopn.com',
          username: Rails.application.secrets.kpopn_username,
          password: Rails.application.secrets.kpopn_password)
    end
  end
end
