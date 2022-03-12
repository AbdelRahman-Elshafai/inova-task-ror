class StoryReviewSerializer
  include JSONAPI::Serializer
  attributes :rating, :comment



  belongs_to :story
  belongs_to :user

end
