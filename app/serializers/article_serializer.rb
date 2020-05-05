class ArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :created_at, :updated_at

  has_many :comments
  has_many :article_likes
end
