# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    author { create(:user) }
    sequence(:content) { |n| "message #{n}" }
  end
end
