# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feature_request do
    requester                { create(:user) }
    sequence(:description)   { |n| "Feature request #{n}" }
  end
end
