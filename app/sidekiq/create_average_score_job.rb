class CreateAverageScoreJob
  include Sidekiq::Job

  def perform(movie_id, score, user_id)
    user = User.find_by_id(user_id)

    movie = Movie.find(movie_id)
    user.movies << movie
    user_movie = user.user_movies.find_by(movie_id: movie.id)
    user_movie.update({ score: })
  end
end
