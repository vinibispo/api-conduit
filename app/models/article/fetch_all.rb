# frozen_string_literal: true

module Article
  class FetchAll < Micro::Case
    attribute :params

    def call!
      articles = Record.includes(:author).all
      Success result: { articles: }
    end
  end
end
