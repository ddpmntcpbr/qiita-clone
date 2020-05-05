class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :created_at, :updated_at, :like_count
  belongs_to :user

  def like_count
    object.article_likes.count
  end
end
