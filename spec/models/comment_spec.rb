require "rails_helper"

RSpec.describe Comment, type: :model do
  context "正常な場合" do
    it "comment が作られる" do
      comment = create(:comment)
      expect(comment.valid?).to eq true
    end
  end

  context "content が指定されていない場合" do
    it "エラーする" do
      comment = build(:comment, content: nil)
      comment.valid?
      expect(comment.errors.messages[:content]).to include "can't be blank"
    end
  end
end
