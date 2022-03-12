require 'rails_helper'

describe 'Stories API', type: :request do
  describe 'GET Stories' do
    it 'should list stories' do
      user = FactoryBot.create(:user , username: 'test')

      FactoryBot.create(:story , user: user, title: 'test title', content: 'test content')
      FactoryBot.create(:story , user: user, title: 'test title 1', content: 'test content 1')

      get "/api/v1/users/#{user.id}/stories?page[number]=1&page[size]=10"

      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)['data'].length).to eq(2)
    end
  end

  describe 'POST Stories' do
    it 'should create story' do

      expect{
        post "/api/v1/stories", params: { story: {title: 'test tile', content: 'test content'}}

      }.to change {Story.count}.from(0).to(1)

      expect(response).to have_http_status(:created)
    end
  end

end

describe 'Story Reviews API', type: :request do
  describe 'POST Story Review' do
    it 'should create story review' do
      user = FactoryBot.create(:user , username: 'test')

      story = FactoryBot.create(:story , user: user, title: 'test title', content: 'test content')

      expect{
        post "/api/v1/stories/#{story.id}/story_reviews?include=story", params: { story_review: {rating: 1, comment: 'test comment'}}

      }.to change {StoryReview.count}.from(0).to(1)

      expect(response).to have_http_status(:created)
    end
  end

end