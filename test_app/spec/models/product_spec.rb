require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'is_valid with description, price & category' do
    product = create(:product)
    expect(product).to be_valid
  end

  # it 'is not valid without description' do
  #   product = build(:product, description: nil)
  #   product.valid?
  #   expect(product.errors[:description]).to include("can't be blank")
  # end

  context "Validations" do
    it { should validate_presence_of(:description)}
    it { should validate_presence_of(:price)}
  end

  context "Association" do
    it { should belong_to(:category)}
  end

  context "Instance method" do
    it '#full_description' do
      product = create(:product)
      expect(product.full_description).to eq("#{product.description} - #{product.price}")
    end    
  end
end
