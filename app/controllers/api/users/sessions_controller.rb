# frozen_string_literal: true

module Api
  module Users
    class SessionsController < ApplicationController
      include ActionController::HttpAuthentication::Token::ControllerMethods

      def show
        authenticate_with_http_token do |token|
          ::User::FindByToken.call(token:)
                             .on_success { |result| render_json_user([result[:user], result[:token]]) }
                             .on_failure(:invalid_token) do |result|
            render json: { errors: result[:message] },
                   status: :unauthorized
          end
        end
      end

      def create
        ::User::SignIn.call(user_params.to_h)
                      .on_success { |result| render_json_user([result[:user], result[:token]]) }
                      .on_failure(:invalid_credentials) do |result|
          render json: { errors: result[:message] },
                 status: :forbidden
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password)
      end

      def render_json_user(user_and_token, status: :ok)
        user, token = user_and_token
        render json: Serializer.new(user:, token:).as_json, status:
      end
    end
  end
end
