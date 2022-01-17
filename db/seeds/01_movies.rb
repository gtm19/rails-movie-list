API_BASE_URL = "https://api.themoviedb.org/3"

# Methods
def tmdb_config
  url = URI("#{API_BASE_URL}/configuration")
  tmdb_api_request(url)
end

def tmdb_img_url
  config = tmdb_config
  config["images"]["secure_base_url"]
end

def top_rated(n = 10, lang = "en", **query_params)
  url = URI("#{API_BASE_URL}/movie/top_rated")
  url.query = URI.encode_www_form(**query_params)
  results = tmdb_api_request(url)["results"]
  results.filter{ |movie| movie["original_language"] == lang }.first(n)
end

def tmdb_api_request(url)
  response = nil
  
  Net::HTTP.start(url.host, url.port, use_ssl: true) do |https|
    request = Net::HTTP::Get.new(url)
    request["Content-Type"] = "application/json;charset=utf-8"
    request["Authorization"] = "Bearer #{ENV['TMDB_API_KEY']}"

    response = https.request(request)
  end

  JSON.parse(response.read_body)
end

# get image url from config
img_url = tmdb_img_url

# only re-seed if there are no movies
# this means you'll have to manually delete them if you want to clear them out
all_movies = Movie.all

if all_movies.empty?
  # get 10 top rated movies
  top_movies_results = top_rated(n = 25)
  # seed each to database
  top_movies_results.each do |result|
    movie = Movie.create(
      title: result["original_title"],
      overview: result["overview"],
      poster_url: result["poster_path"] ? img_url + "w500" + result["poster_path"] : nil,
      rating: result["vote_average"]
    )
    puts "Adding '#{movie.title}' to movies table in db"
  end
else
  puts "Skipping seeding since there are #{ActionController::Base.helpers.pluralize(all_movies.length, "movie")} already in db"
end
