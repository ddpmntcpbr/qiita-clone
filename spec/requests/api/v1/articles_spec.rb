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

    context "指定した id の article が存在しない場合" do
      let(:article_id) { 1_000_000 }

      it "article が見つからない" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "POST api/v1/articles" do
    subject { post(api_v1_articles_path, params: params, headers: headers) }

    let(:headers) { current_user.create_new_auth_token }
    let(:current_user) { create(:user) }
    let(:params) { { article: attributes_for(:article) } }

    context "正しく article を作成する場合" do
      it "article のレコードが作成できる" do
        expect { subject }.to change { current_user.articles.count }.by(1)
        res = JSON.parse(response.body)
        expect(res["title"]).to eq params[:article][:title]
        expect(res["content"]).to eq params[:article][:content]
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "PATCH api/v1/articles" do
    subject { patch(api_v1_article_path(article.id), params: params, headers: headers) }

    let(:headers) { current_user.create_new_auth_token }
    let(:current_user) { create(:user) }
    let(:params) { { article: { title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph, created_at: Time.current } } }

    context "article の作者が自分自身の場合" do
      let(:article) { create(:article, user: current_user) }

      it "更新できる" do
        expect { subject }.to change { article.reload.title }.from(article.title).to(params[:article][:title]) &
                              change { article.reload.content }.from(article.content).to(params[:article][:content]) &
                              not_change { article.reload.created_at }
        expect(response).to have_http_status(:ok)
      end
    end

    context "article の作者が他人の場合" do
      let(:article) { create(:article) }

      it "更新できない" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "DELETE /aoi/v1/articles/:id" do
    subject { delete(api_v1_article_path(article.id), headers: headers) }

    let(:headers) { current_user.create_new_auth_token }
    let(:current_user) { create(:user) }

    before do
      allow_any_instance_of(Api::V1::ApiController).to receive(:current_user).and_return(current_user)
    end

    context "article の作者が自分自身の場合" do
      let!(:article) { create(:article, user: current_user) }

      it "削除できる" do
        expect { subject }.to change { current_user.articles.count }.by(-1)
        expect(response).to have_http_status(:ok)
      end
    end

    context "article の作者が他人の場合" do
      let!(:article) { create(:article) }

      it "削除できない" do
        expect { subject }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end
end
