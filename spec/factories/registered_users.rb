# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :registered_user, class: RegisteredUser, parent: :user do
    email     { "#{username}@example.com" }
    password  "password"
  end
end
