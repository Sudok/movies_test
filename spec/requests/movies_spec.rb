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

      it '' do

      end
    end
  end
end
