FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.paragraph }
    association :article, factory: :article
    user
  end
end
