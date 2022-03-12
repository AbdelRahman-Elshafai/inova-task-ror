Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    namespace :v1 do
      resources :stories , only: [:create]
      get 'stories/top', :to => 'stories#top_stories'

      shallow do
        resources :users , only: [] do
          resources :stories , only: [:index], controller: :user_stories do
            resources :story_reviews, only: [:create]
          end
        end
      end
    end

  end


end
