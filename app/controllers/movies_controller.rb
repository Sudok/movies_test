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

    puts('============================== ENTROU')
    # Ler .csv e criar filmes utilizando background jobs
    uploaded_file = params[:file]
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :director)
  end
end
