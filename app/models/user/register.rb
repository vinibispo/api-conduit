# frozen_string_literal: true

module User
  class Register < Micro::Case
    attributes :username, :email, :password

    validates :username, :email, :password, presence: true

    def call!
      user = Record.new(username:, email:, password:)

      if user.save
        token = ApiToken.generate(user:)
        Success result: { user:, token: }
      else
        Failure :invalid_attributes, result: { errors: user.errors }
      end
    end
  end
end
