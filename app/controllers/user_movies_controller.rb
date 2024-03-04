class UserMoviesController < ApplicationController
  before_action :authenticate_user!

  def create
    @movie = Movie.find(params[:user_movie][:movie_id])
    current_user.movies << @movie
    @user_movie = current_user.user_movies.find_by(movie_id: @movie.id)
    @user_movie.update(score: params[:user_movie][:score])
    redirect_to movies_path
  end

  def update
    @user_movie = current_user.user_movies.find_by(movie_id: params[:user_movie][:movie_id])
    @user_movie.update(score: params[:user_movie][:score])
    redirect_to movies_path
  end

  def batch_import_score_csv
    uploaded_file = params[:file]
    return unless uploaded_file

    CSV.new(uploaded_file.read, headers: true).each do |row|
      create_average_score_job(row)
    end
    redirect_to movies_path, notice: 'Score average was successfully created.'
  end

  private

  def create_average_score_job(row)
    movie_id = row['movie_id']
    score = row['score'].to_i

    if valid_score?(score)
      CreateAverageScoreJob.perform_async(movie_id, score, current_user.id)
    else
      Rails.logger.warn("Invalid score for movie_id #{movie_id}: #{score}")
    end
  end

  def valid_score?(score)
    score >= 0 && score <= 10
  end
end
