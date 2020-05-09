class Api::V1::ArticlesController < Api::V1::ApiController
  before_action :set_article, only:[:update, :destroy]

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

  def update
    @article.update!(article_params)
    render json: @article
  end

  def destroy
    @article.destroy!
    render json: {}, status: :ok
  end

  private

    def article_params
      params.require(:article).permit(:title, :content)
    end

    def set_article
      @article = current_user.articles.find(params[:id])
    end

    # 後でdevise_auth_tokenに取って替わる
    def current_user
      @current_user ||= User.first
    end
end
