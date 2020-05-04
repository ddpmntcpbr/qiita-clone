FactoryBot.define do
  factory :article_like do
    association :user, factory: :user
    association :article, factory: :article
  end
end
