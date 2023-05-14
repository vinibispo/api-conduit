# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users::Sessions' do
  describe 'POST api/users/login' do
    context 'with valid params' do
      it 'returns status code ok' do
        email = 'john@doe.com'
        password = '123456'

        User::Record.create(email:, password:, username: 'johndoe')

        post api_users_login_path, params: { user: { email:, password: } }

        expect(response).to have_http_status(:ok)
      end

      it 'returns the user data' do
        email = 'john@doe.com'
        password = '123456'

        User::Record.create(email:, password:, username: 'johndoe')

        post api_users_login_path, params: { user: { email:, password: } }

        expect(response.parsed_body['user']).to include('email' => email, 'username' => 'johndoe')
      end

      it 'returns the user token' do
        email = 'john@doe.com'
        password = '123456'

        User::Record.create(email:, password:, username: 'johndoe')

        post api_users_login_path, params: { user: { email:, password: } }

        expect(response.parsed_body['user']).to include('token')
      end
    end

    context 'with invalid credentials' do
      it 'returns status forbidden' do
        email = 'john@doe.com'
        password = '123456'

        User::Record.create(email:, password:, username: 'johndoe')

        post api_users_login_path, params: { user: { email:, password: 'wrong' } }

        expect(response).to have_http_status(:forbidden)
      end

      it 'returns error messages' do
        email = 'john@doe.com'
        password = '123456'

        post api_users_login_path, params: { user: { email:, password: } }

        expect(response.parsed_body).to eq({ 'errors' => [{ 'email or password' => ['is invalid'] }] })
      end
    end
  end

  describe 'GET api/user' do
    context 'when the token is valid' do
      it 'returns the status code ok' do
        email = 'john@doe.com'
        password = '123456'
        username = 'johndoe'

        user = User::Record.create(email:, password:, username:)
        token = User::ApiToken.generate(user:)

        get api_user_path, headers: { Authorization: "Token #{token}" }

        expect(response).to have_http_status(:ok)
      end

      it 'returns the user data' do
        email = 'john@doe.com'
        password = '123456'
        username = 'johndoe'

        user = User::Record.create(email:, password:, username:)
        token = User::ApiToken.generate(user:)

        get api_user_path, headers: { Authorization: "Token #{token}" }

        expect(response.parsed_body).to include('user' => { 'email' => email, 'username' => username, 'token' => token,
                                                            'bio' => nil, 'image' => nil, 'id' => user.id })
      end
    end

    context 'when the token is invalid' do
      it 'returns the status code unauthorized' do
        token = 'invalid'

        get api_user_path, headers: { Authorization: "Token #{token}" }

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'PUT api/user' do
    context 'when the token is valid' do
      it 'returns the status code ok' do
        email = 'john@doe.com'
        username = 'johndoe'
        password = '123456'

        user = User::Record.create(email:, password:, username:)

        token = User::ApiToken.generate(user:)

        bio = "I'm John Doe"

        put api_update_user_path, params: { user: { bio: } }, headers: { Authorization: "Token #{token}" }

        expect(response).to have_http_status(:ok)
      end

      it 'updates the user bio' do
        email = 'john@doe.com'
        username = 'johndoe'
        password = '123456'

        user = User::Record.create(email:, password:, username:)

        token = User::ApiToken.generate(user:)

        bio = "I'm John Doe"

        put api_update_user_path, params: { user: { bio: } }, headers: { Authorization: "Token #{token}" }

        expect(response.parsed_body['user']['bio']).to eq(bio)
      end
    end

    context 'when the token is missing' do
      it 'returns the status code unauthorized' do
        email = 'john@doe.com'
        username = 'johndoe'
        password = '123456'

        User::Record.create(email:, password:, username:)


        bio = "I'm John Doe"

        put api_update_user_path, params: { user: { bio: } }

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
