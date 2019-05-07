class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :user
      t.string :review_headline
      t.string :review_body
      t.integer :review_score
      t.timestamps
    end
  end
end
