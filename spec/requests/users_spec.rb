require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'POST /movie' do
    context 'when params is valid' do
      it 'create user' do
        user_params = attributes_for(:user)

        post users_url params: {user: user_params}

        assert_response :redirect
        follow_redirect!
        assert_response :success
      end
    end

    context 'when params is invalid' do
      it 'try create user' do
        user_params = attributes_for(:user, username: nil)

        post users_url params: {user: user_params}

        expect(response).to have_http_status(200)
        assert_equal "Wrong params.", flash[:notice]
      end
    end
  end
end
