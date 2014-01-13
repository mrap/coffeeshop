source 'https://rubygems.org'

ruby '2.0.0'
gem 'rails', '4.0.2'
gem 'zeus'

# Frontend
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 1.2'
gem 'bootstrap-sass'
gem 'haml-rails'
gem 'gon'

# DB
gem 'mongoid', git: 'https://github.com/mongoid/mongoid'
gem 'mongoid_search', git: 'https://github.com/mauriciozaffari/mongoid_search', branch: 'master'
gem 'moped', git: 'https://github.com/mongoid/moped'

# User Auth
gem 'devise'
gem 'bazaar'

# Realtime Messaging
gem 'private_pub'
gem 'thin'
gem 'foreman'


group :production do
  gem 'rails_12factor'
  gem 'unicorn'
  gem 'newrelic_rpm'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'selenium-webdriver'
  gem 'poltergeist' # PhantomJS driver for Capybara tests
end

group :development do
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'terminal-notifier-guard' # Mac OS X 10.8 only
end

group :test do
  gem 'database_cleaner'
  gem 'mongoid-rspec'
  gem 'orderly'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
