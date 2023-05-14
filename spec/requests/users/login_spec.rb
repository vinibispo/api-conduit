# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::Login', type: :request do
  describe 'POST /users/login' do
    it 'works! (now write some real specs)' do
      post users_login_path
      expect(response).to have_http_status(:ok)
    end
  end
end
