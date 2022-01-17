# delete all the bookmarks first
Bookmark.destroy_all

lists = List.all
movies = Movie.all

srand(100)
lists.each do |list|
  num_of_movies = rand(1..movies.length)
  movies_sample = Movie.order("RANDOM()").first(num_of_movies)
  movies_sample.each do |movie|
    bookmark = Bookmark.create(
      movie: movie,
      list: list,
      comment: Faker::Hipster.sentence(word_count: 5)
    )
  end
  puts "Added #{movies_sample.length} movies to #{list.name}"
end
