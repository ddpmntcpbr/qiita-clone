source "https://rubygems.org"
git_source(:github) {|repo| "https://github.com/#{repo}.git" }

ruby "2.6.2"

gem "active_model_serializers", "~> 0.10.0"
gem "bootsnap", ">= 1.1.0", require: false
gem "coffee-rails", "~> 4.2"
gem "devise_token_auth"
gem "mysql2", ">= 0.4.4", "< 0.6.0"
gem "puma", "~> 3.11"
gem "sass-rails", "~> 5.0"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"
gem "webpacker"

group :development, :test do
  gem "factory_bot_rails"
  gem "faker"
  gem "pry-byebug"
  gem "pry-doc"
  gem "pry-rails"
  gem "rspec-rails"
  gem "rubocop-rails"
  gem "rubocop-rspec"
end

group :development do
  gem "annotate"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
  gem 'rails-erd'
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
