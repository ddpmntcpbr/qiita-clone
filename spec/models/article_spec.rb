require "rails_helper"

RSpec.describe Article, type: :model do
  context "正常な場合" do
    it "article が作られる" do
      article = create(:article)
      expect(article.valid?).to eq true
    end
  end

  context "title が指定されていない場合" do
    it "エラーする" do
      article = build(:article, title: nil)
      article.valid?
      expect(article.errors.messages[:title]).to include "can't be blank"
    end
  end

  context "titile が長すぎる場合" do
    it "エラーする" do
      title = "a" * 51
      article = build(:article, title: title)
      article.valid?

      expect(article.errors.messages[:title]).to include "is too long (maximum is 50 characters)"
    end
  end

  context "content が指定されていない場合" do
    it "エラーする" do
      article = build(:article, content: nil)
      article.valid?
      expect(article.errors.messages[:content]).to include "can't be blank"
    end
  end
end
