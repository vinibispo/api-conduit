# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::Sessions' do
  describe 'POST api/users/login' do
    it 'logs in to the application' do
      email = 'john@doe.com'
      password = '123456'
      User::Record.create(email:, password:, username: 'johndoe')
      post api_users_login_path, params: { user: { email:, password: } }
      expect(response).to have_http_status(:ok)
    end

    it 'returns status forbidden when the credentials are invalid' do
      email = 'john@doe.com'
      password = '123456'

      User::Record.create(email:, password:, username: 'johndoe')

      post api_users_login_path, params: { user: { email:, password: 'wrong' } }

      expect(response).to have_http_status(:forbidden)
    end

    it 'returns error messages when the credentials are invalid' do
      email = 'john@doe.com'
      password = '123456'

      post api_users_login_path, params: { user: { email:, password: } }

      expect(response.parsed_body).to eq({ 'errors' => { 'email or password' => ['is invalid'] } })
    end
  end
end
