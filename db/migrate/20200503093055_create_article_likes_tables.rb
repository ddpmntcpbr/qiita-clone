class CreateArticleLikesTables < ActiveRecord::Migration[6.0]
  def change
    create_table :article_likes_tables do |t|
      t.references :user, null: false, foreign_key: true
      t.references :article, null: false, foreign_key: true

      t.timestamps
    end
  end
end
