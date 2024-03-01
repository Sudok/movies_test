require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'creating a user' do
    let(:username) { 'Tony Stark' }
    let(:email) { 'tony@starkindustries.com' }
    let(:password) { 'mark12' }
    let(:password_confirmation) { 'mark12' }
    let(:admin) { true }

    it 'should create a valid movie' do
      user = User.create(username:, email:, password:, password_confirmation:, admin:)

      expect(user).to be_valid
    end

    it 'creates an user with the correct username' do
      user = User.create(username:, email:, password:, password_confirmation:, admin:)
      expect(user.username).to eq(username)
    end

    it 'creates a movie with the correct email' do
      user = User.create(username:, email:, password:, password_confirmation:, admin:)
      expect(user.email).to eq(email)
    end

    it 'does not create an user with an empty username' do
      user = User.create(username: '', email:, password:, password_confirmation:, admin:)
      expect(user).not_to be_valid
    end

    it 'does not create an user with a nil username' do
      user = User.create(username: nil, email:, password:, password_confirmation:, admin:)
      expect(user).not_to be_valid
    end

    it 'does not create an user with a empty email' do
      user = User.create(username:, email: '', password:, password_confirmation:, admin:)
      expect(user).not_to be_valid
    end
  end
end
