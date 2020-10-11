FactoryBot.define do
  factory :order do
    sequence(:description) { |n| "Oder number - #{n}"}
    # association :customer, factory: :customer
    # Pareil que
    customer
  end
end
