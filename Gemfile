source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'mongoid'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.4'
# Use Puma as the app server
gem 'puma'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views

gem 'figaro'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

#Added Gems-------------------------------------
gem 'bootstrap-sass', '3.0.3.0'
gem 'fog'
gem 'carrierwave'
gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'
gem 'mini_magick'
gem 'devise'
# gem 'kaminari'
gem 'kaminari-mongoid'
gem 'kaminari-actionview'

gem 'aws-sdk', '~> 2'

gem 'data_uri'

# Anysoft Gems
gem 'farm_shed', git: 'https://github.com/jessethebuilder/farm_shed', branch: 'lite'
gem 'farm_ruby', git: 'https://github.com/jessethebuilder/farm_ruby'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test, :development do
  gem 'rspec-rails'
  # gem 'wdm'
  gem 'byebug', platform: :mri
  gem 'database_cleaner'
  # , '~> 1.0.0rc'
  gem 'timecop'
  gem 'faker'
end

group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'guard-rspec'
  gem 'selenium-webdriver'
  gem 'shoulda'
  gem 'launchy'
  # , '~> 2.4.0'
  # gem 'phantomjs', :require => 'phantomjs/poltergeist'
  gem 'poltergeist'
  #gem 'webrat'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

ruby '2.6.5'
