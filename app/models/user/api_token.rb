# frozen_string_literal: true

module User
  module ApiToken
    def self.generate(user:)
      payload = { user_id: user.id }
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def self.decode(token:)
      payload = JWT.decode(token, Rails.application.secrets.secret_key_base)
      payload[0]['user_id']
    end
  end
end
