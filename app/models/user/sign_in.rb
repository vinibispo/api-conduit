# frozen_string_literal: true

module User
  class SignIn < Micro::Case
    attributes :email, :password

    validates :email, :password, presence: true

    def call!
      user = User::Record.find_by(email:)

      return Success result: { user: } if user&.authenticate(password)

      Failure :invalid_credentials, result: { message: [{ 'email or password': ['is invalid'] }] }
    end
  end
end
