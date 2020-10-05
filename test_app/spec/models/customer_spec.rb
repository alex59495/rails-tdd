require 'rails_helper'

RSpec.describe Customer, type: :model do
  fixtures :customers

  it '#full_name' do
    # customer = customers(:alex) #fixture method
    # customer = create(:customer)
    customer = create(:user) #using aliases
    expect(customer.full_name).to  start_with("Sr. ")
  end

  it 'Heriting' do
    customer = create(:customer)
    expect(customer.vip).to  be_falsey
  end

  it 'Create with attributes_for' do
    attr = attributes_for(:customer)
    customer = Customer.create(attr)
    expect(customer).to be_kind_of(Customer)
  end

  it '#full_name - Rewritting attributes' do
    # Rewrite the attribute
    customer = create(:customer, name: "Jackson Pires")
    expect(customer.full_name).to  start_with("Sr. Jackson Pires")
  end

  it 'transient attribute' do
    customer = create(:customer_default, upcased: true)
    expect(customer.name.upcase).to eq(customer.name)
  end

  it 'Male customer' do
    customer = create(:customer_male_vip)
    expect(customer.gender).to eq('M')
    expect(customer.vip).to eq(true)
  end

  it { expect{create(:customer)}.to change{Customer.all.count}.by(1)}
end
