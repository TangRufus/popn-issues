Sidetiq.configure do |config|
  # When `true` uses UTC instead of local times (default: false).
  config.utc = false

  # History stored for each worker (default: 50).
  config.worker_history = 500
end
