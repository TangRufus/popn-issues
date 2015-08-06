class SetTermUrlJob < ActiveJob::Base
  queue_as :high

  def perform(term)
    return unless term.url.nil?
    Wordpress::Kpopn.new.set_term_url(term) if term.host == 'kpopn.com'
    Wordpress::Apopn.new.set_term_url(term) if term.host == 'apopn.com'
  end
end
