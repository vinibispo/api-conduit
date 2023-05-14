module Api
  class Users::SessionsController < ApplicationController

    def create
      ::User::SignIn.call(user_params.to_h)
        .on_success { |result| render json: {user: result[:user]}, status: :ok }
        .on_failure(:invalid_credentials) { |result| render json: result[:message], status: :unauthorized }
       .on_failure { |result| render json: result[:errors], status: :unprocessable_entity }
    end

    private
    def user_params
      params.require(:user).permit(:email, :password)
    end
  end
end
