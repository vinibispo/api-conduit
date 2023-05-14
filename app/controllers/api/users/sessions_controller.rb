# frozen_string_literal: true

module Api
  module Users
    class SessionsController < ApplicationController
      def create
        ::User::SignIn.call(user_params.to_h)
                      .on_success { |result| render json: { user: result[:user] }, status: :ok }
                      .on_failure(:invalid_credentials) do |result|
          render json: { errors: result[:message] },
                 status: :forbidden
        end
      end

      private

      def user_params
        params.require(:user).permit(:email, :password)
      end
    end
  end
end
