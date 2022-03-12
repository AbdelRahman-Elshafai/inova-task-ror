class StoryReview < ApplicationRecord
  belongs_to :story
  belongs_to :user

  validates :user, presence: true
  validates :story, presence: true
  validates :comment, length: { maximum: 4294967295 }, presence: true
  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, presence: true

end
