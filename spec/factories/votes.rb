# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :vote do
    votable { create(:feature_request) }
    voter   { create(:user) }

    factory :upvote do
      is_positive? true
    end

    factory :downvote do
      is_positive? false
    end
  end
end
