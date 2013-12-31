# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :guest_user, class: GuestUser, parent: :user do
  end
end
