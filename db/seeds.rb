# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
#
#
require 'faker'

module FAKER_CONSTANTS
  NUMBER_OF_USERS = 20
  NUMBER_OF_STORIES = 200000
  NUMBER_OF_STORY_REVIEWS = 40000
end

users = []
FAKER_CONSTANTS::NUMBER_OF_USERS.times do
  users << {username: Faker::Internet.unique.username }
end
User.insert_all!(users)

stories = []
FAKER_CONSTANTS::NUMBER_OF_STORIES.times do |item|
  random_user = User.find(User.pluck(:id).sample)

  stories << {
    user_id: random_user.id,
    title: Faker::Lorem.word,
    content: Faker::Lorem.paragraph ,
    average_rating: Faker::Number.within(range: 1.0..5.0).round(2),
    number_of_ratings: Faker::Number.within(range: 1..1000000)
  }


end
Story.insert_all!(stories)

story_reviews = []
FAKER_CONSTANTS::NUMBER_OF_STORY_REVIEWS.times do
  random_user = User.find(User.pluck(:id).sample)
  random_story_id = random_user.stories.pluck(:id).sample

  story_reviews << {
    user_id: random_user.id,
    story_id: random_story_id,
    rating: Faker::Number.within(range: 1..5),
    comment: Faker::Lorem.paragraph
  }

end
StoryReview.insert_all!(story_reviews)
