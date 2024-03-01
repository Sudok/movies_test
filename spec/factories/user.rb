FactoryBot.define do
  factory :user do
    username {'ironman'}
    email {'tony@starkindustries.com'}
    password {'mark12'}
    password_confirmation {'mark12'}
    admin { true }
  end
end
