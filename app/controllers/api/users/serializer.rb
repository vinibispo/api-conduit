# frozen_string_literal: true

module Api
  module Users
    class Serializer
      def initialize(user:)
        self.user = user
      end

      def as_json
        {
          user: {
            email: user.email,
            username: user.username,
            id: user.id,
            bio: user.bio,
            image: user.image
          }
        }
      end

      private

      attr_accessor :user
    end
  end
end
