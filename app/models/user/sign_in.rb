# frozen_string_literal: true

module User
  class SignIn < Micro::Case
    attributes :email, :password

    validates :email, :password, presence: true

    def call!
      user = Record.find_by(email:)

      if user&.authenticate(password)
        token = ApiToken.generate(user:)
        return Success result: { user:, token: }
      end

      Failure :invalid_credentials, result: { message: [{ 'email or password': ['is invalid'] }] }
    end
  end
end
