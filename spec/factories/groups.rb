# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group do
    sequence(:name) { |n| "group#{n}" }

    factory :group_with_members do
      ignore do
        members_count 2
      end
      after(:create) do |group, evaluator|
        create_list(:user, evaluator.members_count, group: group)
      end
    end
  end
end
