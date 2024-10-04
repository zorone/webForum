FactoryBot.define do
    factory :user do
        after(:build) { |user| generate_hashed_password(user) }
        email { Faker::Internet.email }
        password { Faker::Internet.password }
    end
end
