class CreateAverageScoreJob
  include Sidekiq::Job

  def perform(movie_id, score, user_id)
    user = User.find_by_id(user_id)
user.inspect
  end
end
