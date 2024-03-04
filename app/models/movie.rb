# frozen_string_literal: true

# Movie represents a film in the application.
#
# It has attributes like title and director, and may have associations with
# user_movies
class Movie < ApplicationRecord
  validates :title, presence: true
  validates :director, presence: true

  has_many :user_movies
  has_many :users, through: :user_movies

  def average_score
    user_movies.average(:score).to_f
  end
end
