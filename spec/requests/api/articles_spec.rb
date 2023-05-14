# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::Articles' do
  describe 'GET /api/articles' do
    context 'when there are no articles' do
      it 'returns an empty array' do
        get '/api/articles'

        expect(response.parsed_body).to eq({ 'articles' => [] })
      end
    end
  end
end
