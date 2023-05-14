# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::Sessions', type: :request do
  describe 'POST api/users/login' do
    it 'works! (now write some real specs)' do
      email = "john@doe.com"
      password = "123456"
      user = User::Record.create(email:, password:, username: "johndoe")
      post api_users_login_path, params: {user: {email:, password: }}
      expect(response).to have_http_status(:ok)
    end
  end
end
