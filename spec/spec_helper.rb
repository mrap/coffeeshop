# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] = 'test' # Orig: ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rspec'
# require 'rspec/autorun' # disabled for Zeus

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|

  # :focus tag for immediate specs
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  # :slow tag to exclude slow tests
  config.filter_run_excluding :slow unless ENV["SLOW_SPECS"]
   # mongoid-rspec matchers

  config.include Mongoid::Matchers, type: :model

  # FactoryGirl
  config.include FactoryGirl::Syntax::Methods

  # Features Helpers
  config.include Features::SessionHelpers, type: :feature

  # Devise Helpers
  config.include Devise::TestHelpers, :type => :controller

  # Capybara uses webkit driver
  Capybara.javascript_driver = :webkit

  require 'database_cleaner'
  config.before(:suite) do
    Mongoid::Indexing.create_indexes
    DatabaseCleaner[:mongoid].strategy = :truncation
  end
  config.after(:suite) do
    # removes /public/test/
    Mongoid::Indexing.remove_indexes
    FileUtils.rm_rf(Dir["#{Rails.root}/public/system/test"])
  end
  config.before(:each) do
    DatabaseCleaner.start
    GC.disable
  end
  config.after(:each) do
    DatabaseCleaner.clean
    GC.enable
  end

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end
