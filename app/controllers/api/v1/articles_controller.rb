class Api::V1::ArticlesController < Api::V1::ApiController
  def index
    articles = Article.order(created_at: :desc)
    render json: articles
  end

  def show
    article = Article.find(params[:id])
    render json: article
  end

  def create
    article = current_user.articles.create!(article_params)
    render json: article
  end

  private

    def article_params
      params.require(:article).permit(:title, :content)
    end

    # 後でdevise_auth_tokenに取って替わる
    def current_user
      @current_user ||= User.first
    end
end
