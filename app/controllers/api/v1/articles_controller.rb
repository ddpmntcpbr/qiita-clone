module Api
  module V1
    class ArticlesController < ApplicationController
      def index
        articles = Article.order(created_at: :desc)
        render json: articles
      end
    end
  end
end