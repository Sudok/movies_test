require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'POST /sessions' do
    let(:user) { create(:user) }

    context 'create session' do
      it 'when loggin is sucessfull' do
        post sessions_url params: {email: user.email, password: user.password}

        assert_response :redirect
        follow_redirect!
        assert_response :success
      end
    end

    context 'destroy session' do
      before do
        sign_in user
      end

      it 'when user logout' do
        delete logout_path

        assert_response :redirect
        follow_redirect!
        assert_response :success
      end
    end
  end
end
