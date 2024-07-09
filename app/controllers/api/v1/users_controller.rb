# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def index
        @users = User.all
        render json: @users
      end

      def show
        @user = User.find(params[:id])
        render json: @user
      end

      def create
        @user = User.create(user_params)

        return render json: @user, status: 201, location: [:api, @user] if @user.save

        render json: { errors: @user.errors }, status: 422
      end

      private

      def user_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
