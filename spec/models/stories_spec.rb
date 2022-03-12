require 'rails_helper'

describe Story, :type => :model do
  before do
    @user = FactoryBot.create(:user , username: 'test')
  end

  it "is valid with valid attributes" do
    expect(Story.new(user: @user, title: 'test title', content: 'test content')).to be_valid
  end

  it "is not valid without a title" do
    expect(Story.new(user: @user, content: 'test content')).to_not be_valid
  end
  it "is not valid with average rating less than 0" do
    expect(Story.new(user: @user,title: 'test title',  content: 'test content' , average_rating: -1)).to_not be_valid
  end
  it "is not valid with average rating more than 5" do
    expect(Story.new(user: @user,title: 'test title',  content: 'test content' , average_rating: 6)).to_not be_valid
  end

  it "is not valid with number of ratings  less than 0" do
    expect(Story.new(user: @user,title: 'test title',  content: 'test content' , number_of_ratings: -1)).to_not be_valid
  end

  it "is not valid with number of ratings other than integer" do
    expect(Story.new(user: @user,title: 'test title',  content: 'test content' , number_of_ratings: 6.5)).to_not be_valid
  end

end