- FB auto post
- Chrome Push Notification
- Logentries
- search
- pagination
- respond_with
- flash messages helper: multiple
- post link --> url


    HTTParty.delete("https://api.cloudflare.com/client/v4/zones/f21a6d4ca6b3bc3222701dcd15f4d060/purge_cache", headers: headers, body: {files: @urls}.to_json )
