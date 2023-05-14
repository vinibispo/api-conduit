# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Users::Registrations' do
  describe 'POST /api/users' do
    context 'when valid params' do
      let(:valid_params) do
        {
          user: {
            username: 'johndoe',
            email: 'john@doe.com',
            password: '123456'
          }
        }
      end

      it 'creates a new user' do
        expect do
          post api_users_register_path, params: valid_params
        end.to change(User::Record, :count).by(1)
      end

      it 'returns status code created' do
        post api_users_register_path, params: valid_params

        expect(response).to have_http_status(:created)
      end

      it 'returns the created user' do
        post api_users_register_path, params: valid_params

        expect(response.parsed_body['user']).to include(
          'email' => 'john@doe.com',
          'username' => 'johndoe',
          'id' => User::Record.last.id,
          'bio' => nil,
          'image' => nil
        )
      end
    end
  end
end
