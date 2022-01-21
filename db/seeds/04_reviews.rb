# delete all the bookmarks first
Review.destroy_all

lists = List.all

srand(100)
lists.each do |list|
  num_of_reviews = rand(0..3)
  num_of_reviews.times do
    Review.create(
      rating: rand(1..10),
      comment: Faker::Hipster.sentence(word_count: 5),
      list: list
    )
  end
  puts "Added #{num_of_reviews} reviews to #{list.name}"
end
