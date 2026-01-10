source "https://rubygems.org"

gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "rails", "~> 8.1.2"

gem "solid_cable"
gem "solid_cache"
gem "solid_queue"

gem "bootsnap", require: false
gem "image_processing", "~> 1.2"
gem "kamal", require: false
gem "rack-cors"
gem "thruster", require: false
gem "tzinfo-data", platforms: %i[windows jruby]

# Authentication
gem "devise"
gem "devise-jwt", "~> 0.11.0"

# API Documentation
gem "rswag"

# Performance Monitoring
gem "rack-mini-profiler"

# Environment Management
gem "dotenv-rails", groups: %i[development test]

group :development, :test do
  gem "brakeman", require: false
  gem "bundler-audit", require: false
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"

  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails"
end

group :development do
  gem "good_migrations", require: false
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
end
