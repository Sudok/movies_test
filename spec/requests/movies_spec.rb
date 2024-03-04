require 'rails_helper'

RSpec.describe 'Movies', type: :request do
  describe 'GET /index' do
    let(:user) { create(:user) }

    context 'when movies exists!' do
      before do
        @movies = create_list(:movie, 3)
        sign_in user
      end

      it 'renders the index template' do
        get movies_url

        expect(response).to be_successful
        expect(response).to have_http_status(200)
        expect(response.content_type).to eq('text/html; charset=utf-8')
      end

      it 'assigns all movies to @movies' do
        get movies_url
        expect(controller.instance_variable_get(:@movies)).to eq(@movies)
      end
    end

    context 'when no movies exist' do
      before do
        sign_in user
      end

      it 'returns a successful response' do
        get movies_url
        expect(response).to be_successful
      end
    end
  end


  describe 'POST /create' do
    let(:user) { create(:user) }

    context 'when params is valid' do
      before do
        sign_in user
      end

      it 'create movie' do
        movie_params = attributes_for(:movie)

        post movies_url params: { movie: movie_params }

        assert_response :redirect
        follow_redirect!
        assert_response :success
      end
    end

    context 'movies with invalid params' do
      before do
        sign_in user
      end

      it 'try create with invalid params' do
        movie_params = attributes_for(:movie, title: nil)

        post movies_url params: { movie: movie_params }

        expect(response).to have_http_status(200)
        assert_equal 'Wrong params.', flash[:notice]
      end
    end

    context 'when user im not logged' do
      it 'try create movies without loggin' do
        movie_params = attributes_for(:movie)

        post movies_url params: { movie: movie_params }

        expect(response).to have_http_status(302)
        assert_equal '', @response.body
      end
    end

    context 'batch csv import' do
      before do
        sign_in user
      end

      let(:valid_file) { fixture_file_upload(Rails.root.join('spec', 'fixtures', 'movies.csv'), 'text/csv') }

      it 'creates movies and redirects to the movies index' do
        expect(CreateMoviesJob).to receive(:perform_async).exactly(30).times
        post movies_import_csv_url, params: { file: valid_file }
        expect(response).to redirect_to(movies_path)
      end
    end
  end
end
