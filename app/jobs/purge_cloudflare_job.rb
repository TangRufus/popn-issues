class PurgeCloudflareJob < ActiveJob::Base
  queue_as :default

  def perform(record)
    CloudflarePurge.new(record).call
  end
end
