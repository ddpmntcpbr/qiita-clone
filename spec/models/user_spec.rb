require "rails_helper"

RSpec.describe User, type: :model do
  context "正常な場合" do
    it "userが作られる" do
      user = create(:user)
      expect(user.valid?).to eq true
    end
  end

  context "name が指定されていない場合" do
    it "エラーする" do
      user = build(:user, name: nil)
      user.valid?

      expect(user.errors.messages[:name]).to include "can't be blank"
    end
  end

  context "name が長すぎる場合" do
    it "エラーする" do
      name = "a" * 51
      user = build(:user, name: name)
      user.valid?

      expect(user.errors.messages[:name]).to include "is too long (maximum is 50 characters)"
    end
  end
end
