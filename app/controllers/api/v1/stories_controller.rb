module Api
  module V1
    class StoriesController < ApplicationController
      include JSONAPI::Errors

      include CustomPaginationHelper

      def create

        @story = Story.create(
          user: User.get_random_user,
          title: story_params[:title],
          content: story_params[:content],
          )

        if @story.valid?
          render jsonapi: @story, status: :created
        else
          render jsonapi_errors: @story.errors, status: :unprocessable_entity
        end
      end

      def top_stories
        @stories = Story.all.order('average_rating DESC').page(get_page_number(top_stories_params)).per(get_page_size(top_stories_params))

        render jsonapi: @stories, status: :ok

      end


      private

      def story_params
        params.require(:story).permit( :title, :content)
      end

      def top_stories_params
        params.permit(:page => [:size, :number])
              .with_defaults(page: { size: 10 , number: 1})
      end

    end

  end
end
