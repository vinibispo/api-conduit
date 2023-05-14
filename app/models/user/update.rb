# frozen_string_literal: true

module User
  class Update < Micro::Case
    attributes :user_attributes, :token
    validates :user_attributes, :token, presence: true

    def call!
      user_id = User::ApiToken.decode(token:)

      user = User::Record.find(user_id)

      return Failure :invalid_token, result: { message: 'Invalid Token' } if user.blank?

      return Success result: { user:, token: } if user.update(user_attributes)

      Failure :invalid_credentials, result: { message: user.errors.messages }
    end
  end
end
