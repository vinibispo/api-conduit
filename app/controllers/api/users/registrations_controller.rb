# frozen_string_literal: true

module Api
  module Users
    class RegistrationsController < ApplicationController
      def create
        User::Register.call(user_params.to_h)
                      .on_success { |result| render_json_user_created([result[:user], result[:token]]) }
                      .on_failure(:invalid_attributes) do |error|
          render json: error,
                 status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:username, :email, :password)
      end

      def render_json_user_created(user_and_token, status: :created)
        user, token = user_and_token
        render json: Serializer.new(user:, token:).as_json, status:
      end
    end
  end
end
