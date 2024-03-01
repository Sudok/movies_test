require 'rails_helper'

RSpec.describe UserMovie, type: :model do
  describe 'creating user' do
    let(:username) { 'Tony Stark' }
    let(:email) { 'tony@starkindustries.com' }
    let(:password) { 'mark12' }
    let(:password_confirmation) { 'mark12' }
    let(:admin) { true }
  end

  describe 'creating user' do
    let(:title) { 'the god father' }
    let(:director) { 'Francis Ford Coppola' }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:movie) }
  end

  describe 'should create a valid average_score' do
    user = User.create(username:, email:, password:, password_confirmation:, admin:)
    movie = Movie.create(title:, director:)
    user_movie = UserMovie.create(user_id: user.id, movie_id: movie.id, score: 7)

    expect(user_movie).to be_valid
  end
end
