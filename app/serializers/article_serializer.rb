class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :created_at, :updated_at, :number_of_likes
  belongs_to :user

  def number_of_likes
    object.article_likes.count
  end
end
