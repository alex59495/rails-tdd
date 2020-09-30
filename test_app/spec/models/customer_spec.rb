require 'rails_helper'

RSpec.describe Customer, type: :model do
  fixtures :customers

  it 'Create a customer' do
    customer = customers(:alex)
    expect(customer.full_name).to  eq("Sr. Alex")
  end
end
