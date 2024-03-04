require 'rails_helper'

RSpec.describe UserMovie, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:movie) }
  end

  describe 'average_score' do
    it 'create a valid user movie(average score)' do
      user =
        User.create(
          username: 'tony stark',
          email: 'tony@starkindustries.com',
          password: 'mark12',
          password_confirmation: 'mark12',
          admin: true
        )

      movie = Movie.create(title: 'Pulp Fiction', director: 'Quentin Tarantino')
      user_movie = UserMovie.create(user_id: user.id, movie_id: movie.id, score: 7)

      expect(user_movie).to be_valid
    end

    it 'when is no have user_id' do
      user =
        User.create(
          username: 'tony stark',
          email: 'tony@starkindustries.com',
          password: 'mark12',
          password_confirmation: 'mark12',
          admin: true
        )

      movie = Movie.create(title: 'Pulp Fiction', director: 'Quentin Tarantino')
      user_movie = UserMovie.create(user_id: nil, movie_id: movie.id, score: 7)

      expect(user_movie).not_to be_valid
    end

    it 'when is no have user_id' do
      user =
        User.create(
          username: 'tony stark',
          email: 'tony@starkindustries.com',
          password: 'mark12',
          password_confirmation: 'mark12',
          admin: true
        )

      movie = Movie.create(title: 'Pulp Fiction', director: 'Quentin Tarantino')
      user_movie = UserMovie.create(user_id: user.id, movie_id: nil, score: 7)

      expect(user_movie).not_to be_valid
    end
  end
end
