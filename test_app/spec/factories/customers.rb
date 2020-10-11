FactoryBot.define do
  factory :customer, aliases: [:user] do
    transient do
      upcased { false }
      qtt_orders { 3 }
    end

    name { Faker::Name.name }
    address { Faker::Address.street_address}
    # email { Faker::Internet.email }

    sequence(:email) { |n| "meu-email#{n}@test.com "}
    
    trait :male do
      gender { 'M' }
    end

    trait :female do
      gender { 'F' }
    end

    trait :vip do
      vip { true }
      days_to_pay { 30 }
    end

    trait :default do
      vip { false }
      days_to_pay { 10 }
    end

    trait :with_orders do
      after(:create) do |customer, evaluator|
        create_list(:order, evaluator.qtt_orders, customer: customer)
      end
    end

    factory :customer_male, traits: [:male]
    factory :customer_female, traits: [:female]
    factory :customer_vip, traits: [:vip]
    factory :customer_male_vip, traits: [:male, :vip]
    factory :customer_default, traits: [:default]


    after(:create) do |customer, evaluator|
      customer.name.upcase! if evaluator.upcased
    end
  end
end