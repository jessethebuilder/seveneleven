FactoryGirl.define do
  sequence(:email){ |x| "user#{x}@test.com" }

  factory :user do
    email
    password "password"

    factory :admin do
      admin true
    end
  end

  factory :na_store do

  end

  factory :intl_store do

  end

  factory :playlist do
    name {Faker::Business.catch_phrase}
  end
end
