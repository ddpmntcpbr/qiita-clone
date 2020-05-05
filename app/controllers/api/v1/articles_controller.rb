class Api::V1::ArticlesController < Api::V1::ApiController
  def index
    articles = Article.order(created_at: :desc)
    render json: articles
  end
end
