require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'creating a movie' do
    let(:title) { 'the god father' }
    let(:director) { 'Francis Ford Coppola' }

    it 'should create a valid movie' do
      movie = Movie.create(title:, director:)
      expect(movie).to be_valid
    end

    it 'creates a movie with the correct title' do
      movie = Movie.create(title:, director:)
      expect(movie.title).to eq(title)
    end

    it 'creates a movie with the correct director' do
      movie = Movie.create(title:, director:)
      expect(movie.director).to eq(director)
    end

    it 'does not create a movie with an empty title' do
      movie = Movie.create(title: '', director:)
      expect(movie).not_to be_valid
    end

    it 'does not create a movie with a nil title' do
      movie = Movie.create(title: nil, director:)
      expect(movie).not_to be_valid
    end

    it 'does not create a movie with a nil director' do
      movie = Movie.create(title:, director: nil)
      expect(movie).not_to be_valid
    end
  end

  describe 'list movies' do
    it 'return all movies' do
      movie1 = Movie.create(title: 'Movie 1', director: 'Director 1')
      movie2 = Movie.create(title: 'Movie 2', director: 'Director 2')

      movies = Movie.all

      expect(movies).to match_array([movie1, movie2])
    end

    it 'returns an empty array when there are no movies' do
      result = Movie.all

      expect(result).to eq([])
    end
  end
end
