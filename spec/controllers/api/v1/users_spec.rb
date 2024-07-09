# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  before(:each) { request.headers['Accept'] = 'application/localhost:3000.v1' }

  describe 'GET /index' do
    before(:each) do
      @user = FactoryBot.create :user
      get :show, params: { id: @user.id }, format: :json

      it 'returns the information about a reporter on hash' do
        @user_response = JSON.parse(response.body, symbolize_names: true)
        puts @user.email
        puts user_response[:email]
        expect(@user_response[:email]).to eq @user.emal
      end

      it { should respond_with :ok }
    end
  end

  describe 'POST #create' do
    context 'when is successfully created' do
      before(:each) do
        @user_attributes = FactoryBot.attributes_for :user
        post :create, params: { user: @user_attributes }, format: :json
      end

      it 'renders the json representation for the user record just created' do
        @user_response = JSON.parse(response.body, symbolize_names: true)
        expect(@user_response[:email]).to eq @user_attributes[:email]
      end
      it { should respond_with 201 }
    end

    context 'when is not created' do
      before(:each) do
        @invalid_user = {
          password: '123123'
        }
        post :create, params: { user: @invalid_user }, format: :json
      end

      it 'renders json erro' do
        @user_response = JSON.parse(response.body, symbolize_names: true)
        expect(@user_response).to have_key(:errors)
      end

      it 'renders the json errors on why the user could not be created' do
        @user_response = JSON.parse(response.body, symbolize_names: true)
        expect(@user_response[:errors][:email]).to include 'can\'t be blank'
      end
    end
  end
end