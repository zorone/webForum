FactoryBot.define do
    sequence :email do |n|
        "person#{n}@example.com"
    end

    factory :user do
        after(:build) { |user| generate_hashed_password(user) }

        email
    end
end
