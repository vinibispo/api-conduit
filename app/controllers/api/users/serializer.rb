# frozen_string_literal: true

module Api
  module Users
    class Serializer
      def initialize(user:, token:)
        self.user = user
        self.token = token
      end

      def as_json
        {
          user: {
            email: user.email,
            username: user.username,
            token:,
            id: user.id,
            bio: user.bio,
            image: user.image
          }
        }
      end

      private

      attr_accessor :user, :token
    end
  end
end
