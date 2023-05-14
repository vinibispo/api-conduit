# frozen_string_literal: true

module Api
  module Articles
    class Serializer
      def initialize(articles:)
        self.articles = articles
      end

      def as_json
        { articles: articles.map do |article|
          {
            title: article.title,
            slug: article.slug,
            body: article.body,
            description: article.description,
            createdAt: article.created_at,
            updatedAt: article.updated_at,
            favorited: false,
            favoritesCount: 0,
            author: {
              username: article.author.username,
              bio: article.author.bio,
              image: article.author.image,
              following: false
            }
          }
        end }
      end

      private

      attr_accessor :articles
    end
  end
end
