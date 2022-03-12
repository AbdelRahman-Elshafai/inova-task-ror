class CreateStories < ActiveRecord::Migration[7.0]
  def change
    create_table :stories do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.text :title, null:false
      t.text :content, null:true
      t.decimal :average_rating, default:0
      t.bigint :number_of_ratings, default:0

      t.timestamps
    end
  end
end
