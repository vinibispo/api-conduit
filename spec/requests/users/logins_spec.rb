require 'rails_helper'

RSpec.describe 'Users::Logins', type: :request do
  describe 'GET /users/logins' do
    it 'works! (now write some real specs)' do
      get users_logins_path
      expect(response).to have_http_status(200)
    end
  end
end
