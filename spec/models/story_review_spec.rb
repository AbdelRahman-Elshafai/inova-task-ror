require 'rails_helper'

describe StoryReview, :type => :model do
  before do
    @user = FactoryBot.create(:user , username: 'test')
    @story = FactoryBot.create(:story , user: @user, title: 'test title', content: 'test content')
  end

  it "is valid with valid attributes" do
    expect(StoryReview.new(user: @user, story: @story, comment: 'test comment' , rating: 3)).to be_valid
  end

  it "is not valid without a comment" do
    expect(StoryReview.new(user: @user, story: @story, rating: 3)).to_not be_valid
  end

  it "is not valid without a rating" do
    expect(StoryReview.new(user: @user, story: @story, comment: 'test comment')).to_not be_valid
  end

  it "is not valid with rating more than 5" do
    expect(StoryReview.new(user: @user, story: @story, comment: 'test comment' , rating: 6)).to_not be_valid
  end

  it "is not valid with rating  less than 0" do
    expect(StoryReview.new(user: @user, story: @story, comment: 'test comment' , rating: -1)).to_not be_valid
  end
  it "is not valid with rating not an integer" do
    expect(StoryReview.new(user: @user, story: @story, comment: 'test comment' , rating: "hello")).to_not be_valid
  end

end