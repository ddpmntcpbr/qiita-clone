require "rails_helper"

RSpec.describe "Api::V1::Auth::Registrations", type: :request do
  describe "POST /api/v1/auth" do
    subject { post(user_registration_path, params: params) }

    context "必要なパラメータを送信したとき" do
      let(:params) { attributes_for(:user).slice(:name,:email,:password) }

      it "ユーザー登録できる" do
        expect { subject }.to change { User.count }.by(1)
        res = JSON.parse(response.body)
        expect(res["status"]).to eq("success")
        expect(res["data"]["id"]).to eq(User.last.id)
        expect(res["data"]["email"]).to eq(User.last.email)
        expect(response).to have_http_status(200)
      end
    end

    context "emailが不足しているとき" do
      let(:params) { attributes_for(:user).slice(:name,:password) }

      it "ユーザー登録ができない" do
        expect { subject }.to change { User.count }.by(0)
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(res["errors"]["email"]).to match_array  ["can't be blank"]
      end
    end

    context "すでに同一のemailが登録されているとき" do

      before { create(:user, email: email) }
      let(:email) { Faker::Internet.email }
      let(:params) { attributes_for(:user, email: email).slice(:name,:email,:password) }

      it "ユーザー登録ができない" do
        expect { subject }.to change { User.count }.by(0)
        res = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(res["errors"]["email"]).to match_array ["has already been taken"]
      end
    end
  end
end