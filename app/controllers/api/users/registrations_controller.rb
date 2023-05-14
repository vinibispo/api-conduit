# frozen_string_literal: true

module Api
  module Users
    class RegistrationsController < ApplicationController
      def create
        User::Register.call(user_params.to_h)
                      .on_success { |result| render json: user_serializer(result[:user]), status: :created }
                      .on_failure(:invalid_attributes) do |error|
          render json: error,
                 status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:username, :email, :password)
      end

      def user_serializer(user)
        Serializer.new(user:).as_json
      end
    end
  end
end
