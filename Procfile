web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb > /dev/null 2>&1
worker: bundle exec sidekiq -q critical -q high -q default -q mailers -q low
log: rm log/development.log && touch log/development.log && tail -f log/development.log
