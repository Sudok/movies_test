require 'rails_helper'

RSpec.describe 'UserMovies', type: :request do
  describe 'POST /create' do
    let(:user) { create(:user) }
    let(:movie) { create(:movie) }

    context 'creating average score for movie' do
      before do
        sign_in user
      end

      it 'create user review' do
        post user_movies_url params: {user_movie: {movie_id: movie.id, score: 10}}
      end
    end
  end
end
