# frozen_string_literal: true

module User
  class FindByToken < Micro::Case
    attributes :token

    def call!
      user_id = User::ApiToken.decode(token:)

      user = User::Record.find(user_id)

      Success result: { user:, token: }
    rescue JWT::DecodeError
      Failure :invalid_token, result: { message: 'Invalid token' }
    end
  end
end
