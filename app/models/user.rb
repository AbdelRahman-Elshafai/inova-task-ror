class User < ApplicationRecord
  has_many :stories
  has_many :story_reviews

  validates :username, length: { in: 3..255 }, presence: true, uniqueness: true



  def self.get_random_user
    random_id = User.pluck(:id).sample

    if random_id.blank?

      return User.create(username: self.get_random_username)
    end

    user = User.find(random_id)

    if user.blank?
      return User.create(username: self.get_random_username)
    end

    return user

  end

  def self.get_random_username
    "user-#{ SecureRandom.hex(10)}"
  end




end
