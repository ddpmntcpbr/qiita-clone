require "rails_helper"

RSpec.describe Comment, type: :model do
  context "正常な場合" do
    let(:comment) { create(:comment) }

    it "comment が作られる" do
      expect(comment.valid?).to eq true
    end
  end

  context "content が指定されていない場合" do
    let(:comment) { build(:comment, content: nil) }

    it "エラーする" do
      comment.valid?
      expect(comment.errors.messages[:content]).to include "can't be blank"
    end
  end
end
