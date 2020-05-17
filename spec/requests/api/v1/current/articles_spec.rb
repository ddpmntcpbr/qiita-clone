require "rails_helper"

RSpec.describe "Api::V1::Current::Articles", type: :request do
  describe "GET api/v1/current/articles" do
    subject { get(api_v1_current_articles_path, headers: headers) }

    let(:headers) { current_user.create_new_auth_token }
    let(:current_user) { create(:user) }

    context "カレントユーザーが公開状態の articles を保存している場合" do
      before do
        create_list(:article, 3, user: current_user)
        create_list(:article, 2, :save_draft, user: current_user)
      end

      it "公開状態の article の一覧が取得できる" do
        subject
        expect(Article.count).to eq 5
        res = JSON.parse(response.body)
        expect(res.length).to eq 3
        expect(res[0].keys).to eq ["id", "title", "content", "created_at", "updated_at", "likes_count", "user"]
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
