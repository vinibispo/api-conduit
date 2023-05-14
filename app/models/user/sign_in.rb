# frozen_string_literal: true

module User
  class SignIn < Micro::Case
    attributes :email, :password

    validates :email, :password, presence: true

    def call!
      user = User::Record.find_by(email:)

      if user&.authenticate(password)
        Success result: { user: }
      else
        Failure(:invalid_credentials) { { message: 'Invalid credentials' } }
      end
    end
  end
end
