class CreateStoryReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :story_reviews do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :story, index: true, foreign_key: true
      t.integer :rating, null:false
      t.text :comment, null:false

      t.timestamps
    end
  end
end
