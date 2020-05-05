require "rails_helper"

RSpec.describe "Articles", type: :request do
  describe "GET api/v1/articles" do
    subject { get(api_v1_articles_path) }

    context "DB 上に article レコードが存在する場合" do
      before do
        create_list(:article, 3)
      end

      it "article の一覧が取得できる" do
        subject
        res = JSON.parse(response.body)
        expect(res.length).to eq 3
        expect(res[0].keys).to eq ["id", "title", "content", "created_at", "updated_at", "likes_count", "user"]
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "GET api/v1/articles::id" do
    subject { get(api_v1_article_path(article_id)) }

    context "指定した id の article が存在する場合" do
      let(:article) { create(:article) }
      let(:article_id) { article.id }

      it "任意の article の値が取得できる" do
        subject
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)

        expect(res["title"]).to eq article.title
        expect(res["content"]).to eq article.content
        expect(res["likes_count"]).to eq article.article_likes.count
        expect(res["user"]["id"]).to eq article.user.id
        expect(res["user"]["name"]).to eq article.user.name
      end
    end
  end
end
