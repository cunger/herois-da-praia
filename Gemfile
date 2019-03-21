source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'rails', '~> 5.2.2.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.11'
gem 'turbolinks', '~> 5'

gem 'haml-rails'
gem 'font-awesome-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'serviceworker-rails'

gem 'active_record_enumerated_type'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

group :development, :test do
  gem 'rspec-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'pry'
  gem 'factory_bot_rails', require: false
  gem 'database_cleaner'
  gem 'rails-controller-testing'
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver', '>= 3.14'
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
