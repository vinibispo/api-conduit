# frozen_string_literal: true

module Article
  class Record < ApplicationRecord
    self.table_name = 'articles'

    belongs_to :author, class_name: '::User::Record'
  end
end
