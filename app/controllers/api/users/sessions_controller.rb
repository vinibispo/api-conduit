# frozen_string_literal: true

module Api
  module Users
    class SessionsController < ApplicationController
      include ActionController::HttpAuthentication::Token::ControllerMethods

      def show
        http_token_response = authenticate_with_http_token do |token|
          ::User::FindByToken
            .call(token:)
        end

        if http_token_response.nil?
          render_unauthorized('Token not found')
          return
        end

        http_token_response
          .on_success { |result| render_json_user([result[:user], result[:token]]) }
          .on_failure(:invalid_token) { |result| render_unauthorized(result[:message]) }
      end

      def create
        ::User::SignIn.call(user_params.to_h)
                      .on_success { |result| render_json_user([result[:user], result[:token]]) }
                      .on_failure(:invalid_credentials) do |result|
          render json: { errors: result[:message] },
                 status: :forbidden
        end
      end

      def update
        http_token_response = authenticate_with_http_token do |token|
          ::User::Update
            .call(token:, user_attributes: update_user_params.to_h)
        end
        if http_token_response.nil?
          render_unauthorized('Token not found')
          return
        end
        http_token_response
          .on_success { |result| render_json_user([result[:user], result[:token]]) }
          .on_failure(:invalid_token) { |result| render_unauthorized(result[:message]) }
          .on_failure(:invalid_user_attributes) do |result|
          render json: { errors: result[:message] }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password)
      end

      def update_user_params
        params.require(:user).permit(:email, :username, :password, :bio, :image)
      end

      def render_json_user(user_and_token, status: :ok)
        user, token = user_and_token
        render json: Serializer.new(user:, token:).as_json, status:
      end

      def render_unauthorized(message)
        render json: { errors: message }, status: :unauthorized
      end
    end
  end
end
