20.times do |_n|
  name = Faker::Name.name
  email = "#{_n}_" + Faker::Internet.email
  password = Faker::Internet.password(min_length: 10)
  User.create!(
    name: name,
    email: email,
    password: password,
  )
end

100.times do |_n|
  title = Faker::Lorem.sentence
  content = Faker::Lorem.paragraph
  user_id = User.all.to_a.map(&:id).sample
  Article.create!(
    title: title,
    content: content,
    user_id: user_id,
  )
end

300.times do |_n|
  content = Faker::Lorem.paragraph
  user_id_array = User.all.to_a.map(&:id)
  user_id = user_id_array.sample
  user_id_array.delete(user_id)
  other_user_id = user_id_array.sample
  article_id = Article.where(user_id: other_user_id).to_a.map(&:id).sample
  next unless article_id

  Comment.create!(
    content: content,
    user_id: user_id,
    article_id: article_id,
  )
end

Article.find_each do |article|
  user_id_array = User.all.to_a.map(&:id)
  user_id_array.delete(article.user.id)
  others_user_id_array = user_id_array
  others_user_id_array.each do |other_user_id|
    next unless [true, false].sample

    ArticleLike.create!(
      user_id: other_user_id,
      article_id: article.id,
    )
  end
end
