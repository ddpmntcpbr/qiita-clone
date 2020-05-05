class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :created_at, :updated_at, :likes_count
  belongs_to :user

  def likes_count
    object.article_likes.count
  end
end
