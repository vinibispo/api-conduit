module Api
  class Users::SessionsController < ApplicationController
    def create
      render json: { message: 'ok' }, status: :ok
    end
  end
end
