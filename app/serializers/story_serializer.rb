class StorySerializer
  include JSONAPI::Serializer
  attributes :title, :content, :user_id, :number_of_ratings


  attribute :average_rating do |object|
    object.average_rating.to_f
  end


end
