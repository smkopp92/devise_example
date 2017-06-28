FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "Ever #{n}" }
    last_name "Greatest"
    sequence(:email) { |n| "Imnottelling#{n}@you.ever" }
    password "supersecret"
    password_confirmation "supersecret"
  end
end
