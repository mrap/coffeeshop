source 'https://rubygems.org'

ruby '2.0.0'
gem 'rails', '4.0.1'

# Frontend
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'bootstrap-sass'
gem 'haml-rails'
gem 'gon'

# DB
gem 'mongoid', github: 'mongoid/mongoid'
gem 'mongoid_indexing'
gem 'mongoid_search'

# User Auth
gem 'devise'
gem 'bazaar'

# Realtime Messaging
gem 'private_pub'
gem 'thin'

# Heroku
gem 'rails_12factor'

# Development
gem 'zeus'

group :test, :development do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

group :development do
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'terminal-notifier-guard' # Mac OS X 10.8 only
end

group :test do
  gem 'database_cleaner'
  gem 'mongoid-rspec'
  gem 'capybara'
  gem 'orderly'
  gem 'selenium-webdriver'
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
