require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  before(:each) {request.headers['Accept'] = 'application/localhost:3000.v1'}
  
  describe "GET /index" do
    before(:each) do 
      @user = FactoryBot.create :user
      get :show, params: { id: @user.id }, format: :json

      it 'returns the information about a reporter on hash' do 
        user_response = JSON.parse(response.body, symbolize_names: true)
        puts @user.email 
        puts user_response[:email]
        expect(user_response[:email]).to eq @user.emal
      end

      it {should respond_with :ok}
    end
  end
end
