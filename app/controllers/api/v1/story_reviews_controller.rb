module Api
  module V1
    class StoryReviewsController < ApplicationController
      include JSONAPI::Errors
      include JSONAPI::Fetching

      def create


        @story = Story.find(params[:story_id])

        @review = @story.story_reviews.create(
          user: @story.user,
          rating: story_review_params[:rating],
          comment: story_review_params[:comment],
          )

        unless @review.valid?
          render jsonapi_errors: @review.errors, status: :unprocessable_entity
        end

        @story.update_rating(story_review_params[:rating])

        unless @review.valid?
          render jsonapi_errors: @story.errors, status: :unprocessable_entity
        end

        render jsonapi: @review, status: :created

      end

      def jsonapi_include
        super & ['story']
      end

      private

      def story_review_params
        params.require(:story_review).permit(:user_id , :story_id,  :rating, :comment)
      end

    end

  end
end
