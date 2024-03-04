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
        post user_movies_url params: { user_movie: { movie_id: movie.id, score: 10 } }

        assert_response :redirect
        follow_redirect!
        assert_response :success
      end

      it 'try create average score with invalid params' do
        post user_movies_url params: { user_movie: { movie_id: nil, score: 10 } }

        expect(response).to have_http_status(404)
      end
    end

    context 'update average score for movies' do
      before do
        sign_in user
        @user_movie = create(:user_movie, user_id: user.id, movie_id: movie.id, score: 9)
      end

      it 'update user review' do
        update_params = {
          user_movie: {
            movie_id: @user_movie.movie_id,
            score: 10
          }
        }

        patch "/user_movies/#{@user_movie.movie_id}", params: update_params

        @user_movie.reload

        expect(@user_movie.score).to eq(10)
        expect(response).to redirect_to(movies_path)
      end
    end

    context 'batch csv score import' do
      before do
        sign_in user
        @movies = create_list(:movie, 10)
      end

      let(:valid_file) { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'score_test.csv'), 'text/csv') }

      it 'creates movies and redirects to the movies index' do
        expect(CreateAverageScoreJob).to receive(:perform_async).exactly(9).times
        post user_movies_batch_import_score_csv_url, params: { file: valid_file }
        expect(response).to redirect_to(movies_path)
      end
    end
  end
end
