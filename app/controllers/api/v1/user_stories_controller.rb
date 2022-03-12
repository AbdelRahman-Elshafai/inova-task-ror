module Api
  module V1
    class UserStoriesController < ApplicationController
      include JSONAPI::Errors

      include CustomPaginationHelper

      def index


        @user  = User.find(user_stories_params[:user_id])
        @stories = @user.stories.order(:id).page(get_page_number(user_stories_params)).per(get_page_size(user_stories_params))

        render jsonapi: @stories , status: :ok


      end


      private

      def user_stories_params
        params
          .permit(:user_id, :page => [:size, :number])
          .with_defaults(page: { size: 10 , number: 1})
      end

      def render_jsonapi_internal_server_error(exception)
        # Call your exception notifier here. Example:
        # Raven.capture_exception(exception)
        super(exception)
      end


    end

  end
end
