class CloudflarePurge
  def initialize(record)
    @record = record
    @urls = record.purge_urls
    @host = record.host
  end

  def call
    return unless @record.should_purge?
    response = HTTParty.delete("https://api.cloudflare.com/client/v4/zones/#{zone_id}/purge_cache", headers: headers, body: body)

    return unless response.parsed_response['success']
    @record.purged_at = Time.zone.now
    @record.save!
  end

  private

  def headers
    {
      'X-Auth-Email' => Rails.application.secrets.cloudflare_email,
      'X-Auth-Key' => Rails.application.secrets.cloudflare_api_key,
      'Content-Type' => 'application/json'
    }
  end

  def zone_id
    return Rails.application.secrets.kpopn_zone_id if @host == 'kpopn.com'
    return Rails.application.secrets.apopn_zone_id if @host == 'apopn.com'
  end

  def body
    {files: @urls}.to_json
  end
end
