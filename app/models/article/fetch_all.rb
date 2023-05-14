class Article::FetchAll < Micro::Case
  attribute :params

  def call!
    articles = Article::Record.all
    Success result: { articles: }
  end
end
