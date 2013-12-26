source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.1'

# Frontend
gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'
gem 'anjlab-bootstrap-rails', :require => 'bootstrap-rails', :github => 'anjlab/bootstrap-rails'

# DB
gem 'mongoid', github: 'mongoid/mongoid'
gem 'bson_ext'
gem 'mongoid_indexing'
gem 'mongoid_search'

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
