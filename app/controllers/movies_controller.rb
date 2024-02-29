class MoviesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user!

  def index
    @movies = Movie.all
    respond_to do |format|
      format.html
      format.json { render json: @movies.to_json(methods: :average_score) }
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path, notice: "Movie was successfully created."
    else
      render :new
    end
  end

  def import_csv
    uploaded_file = params[:file]

    if params[:file]
      CSV.new(uploaded_file.read, headers: true).each do |row|

      CreateMoviesJob.perform_async(row["title"], row["director"])
      end
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :director)
  end
end
