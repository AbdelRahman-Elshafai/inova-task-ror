class Story < ApplicationRecord
  belongs_to :user
  has_many :story_reviews

  validates :user, presence: true
  validates :title, length: { maximum: 60 }, presence: true
  validates :content, length: { maximum: 4294967295 }, unless: -> { content.blank? }  #longtext max value
  validates :average_rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }, presence: true , format: { with: /\A\d+(?:\.\d{0,2})?\z/ }
  validates :number_of_ratings, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, presence: true


  attribute :average_rating, default: 0
  attribute :number_of_ratings, default: 0

  def update_rating(rating)

    new_number_of_ratings = self.number_of_ratings.to_i + 1
    overall_rating = ( ( self.average_rating.to_f * self.number_of_ratings.to_i ) + get_weighed_rating(rating.to_i) ) / (new_number_of_ratings)

    self.update_columns(average_rating: overall_rating.to_f.truncate(2), number_of_ratings: new_number_of_ratings)
  end

  private

  def get_weighed_rating(rating)

    case rating
      when 1
        weight = 0.2
      when 2
        weight = 0.4
      when 3
        weight = 0.6
      when 4
        weight = 0.8
      when 5
        weight = 1
      else
        weight = 0
      end

    weight
  end
end
