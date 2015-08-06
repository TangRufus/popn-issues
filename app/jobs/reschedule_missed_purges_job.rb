class RescheduleMissedPurgesJob < ActiveJob::Base
  queue_as :low

  def perform
    Post.where(purged_at: nil).find_each do |post|
      PurgeCloudflareJob.perform_later(post)
    end
  end
end
