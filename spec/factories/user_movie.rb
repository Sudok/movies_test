FactoryBot.define do
  factory :user_movie do
    user_id { create(:user) }
    movie_id { create(:movie) }
    score { rand(0..10) }
  end
end
