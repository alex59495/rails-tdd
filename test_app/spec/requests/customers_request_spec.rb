require 'rails_helper'

RSpec.describe "Customers", type: :request do
  
  context "As a Guest" do
    context "index" do
      it 'response successfully to index' do
        get customers_path
        expect(response).to be_successful
      end
    
      it 'responds a 200 response to index' do
        get customers_path
        expect(response).to have_http_status "200"
      end      
    end 

    it 'respond a 302 to show (not authorized)'do
      get customer_path(Customer.first.id)
      expect(response).to have_http_status "302"
    end

  end

  context "Logged user" do

    before do
      @member = create(:member)
      @customer = create(:customer)
    end

    it 'Content-Type' do
      customer_params = attributes_for(:customer)
      sign_in @member
      get customer_path(Customer.first), params: { format: :json }
      expect(response.content_type).to match(/application\/json/)
    end

    it 'Flash Notice' do
      customer_params = attributes_for(:customer)
      sign_in @member
      post customers_path(customer: customer_params)
      expect(flash[:notice]).to match(/successfully created/)
    end

    it 'Create with valid atributes' do
      customer_params = attributes_for(:customer)
      sign_in @member
      expect {
        post customers_path(customer: customer_params)
      }.to change(Customer, :count).by(1)
    end

    it 'Invalid atributes' do
      customer_params = attributes_for(:customer, address: nil)
      sign_in @member
      expect {
        post customers_path(customer: customer_params)
      }.not_to change(Customer, :count)
    end

    it 'Render template for show' do
      @member = FactoryBot.create(:member)
      sign_in @member
      get customer_path(Customer.first.id)
      expect(response).to render_template(:show)
    end    
  end
end
