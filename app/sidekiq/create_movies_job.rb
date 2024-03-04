class CreateMoviesJob
  include Sidekiq::Job

  sidekiq_options retry: 5

  def perform(title, director)
    movie = Movie.new({"title" => title, "director" => director})
    movie.save
  end
end
