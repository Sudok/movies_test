require 'rails_helper'

RSpec.describe "Movies", type: :request do
  describe "GET /index" do
    let(:user) { create(:user) }

    before do
      @movies = create_list(:movie, 3)
      sign_in user
    end

    it "renders the index template" do
      session[:user_id] =  @user.id

      get "/movies"
      expect(response).to have_http_status(200)
      expect(response.content_type).to eq("text/html")
    end
  end
end

# RSpec.describe MoviesController, type: :controller do

#   describe "GET #index" do
#     context "when movies exist" do
#       before do
#         @movies = create_list(:movie, 3) # Create 3 sample movies
#       end

#       it "returns a successful response" do
#         get :index
#         expect(response).to be_successful
#       end

#       it "renders the index template" do
#         get :index
#         expect(response).to render_template(:index)
#       end

#       it "assigns all movies to @movies" do
#         get :index
#         expect(assigns(:movies)).to eq(@movies)
#       end

#       context "format is JSON" do
#         it "renders movies as JSON with average_score" do
#           get :index, format: :json
#           expect(response.content_type).to eq("application/json; charset=utf-8")
#           expect(JSON.parse(response.body)).to contain_exactly(*@movies.map(&:as_json).map {|j| j.merge({average_score: j['average_score']}) })
#         end
#       end
#     end

#     context "when no movies exist" do
#       it "returns a successful response" do
#         get :index
#         expect(response).to be_successful
#       end

#       it "renders the index template" do
#         get :index
#         expect(response).to render_template(:index)
#       end

#       it "assigns an empty array to @movies" do
#         get :index
#         expect(assigns(:movies)).to be_empty
#       end
#     end
#   end
# end
