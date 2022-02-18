source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 2.7.4'

gem 'rails', '~> 7.0.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 5'
gem 'sass-rails', '~> 5'
gem 'webpacker', '~> 5.x'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem 'ip_anonymizer'

# Use Active Storage variant
gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

gem "rubyzip", ">= 1.3.0"

gem 'browser'

gem 'friendly_id', '~> 5.2.4'

gem "aws-sdk-s3", require: false

# SEO
gem "sitemap_generator"

# markdown to html
gem "redcarpet"

group :development, :test do
  gem 'pry-byebug'
  gem 'rubocop', require: false
  %w[rspec-core rspec-expectations rspec-mocks rspec-rails rspec-support].each do |lib|
    gem lib, git: "https://github.com/rspec/#{lib}.git", branch: 'master'
  end
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'brakeman'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'factory_bot_rails'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'webmock'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
