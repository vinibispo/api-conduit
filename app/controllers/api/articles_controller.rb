# frozen_string_literal: true

module Api
  class ArticlesController < ApplicationController
    def index
      Article::FetchAll
        .call
        .on_success do |result|
        render json: ::Api::Articles::Serializer.new(articles: result[:articles]).as_json,
               status: :ok
      end
    end
  end
end
