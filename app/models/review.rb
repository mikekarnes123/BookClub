class Review < ApplicationRecord
  validates_presence_of :user
  validates_presence_of :review_headline
  validates_presence_of :review_score
  validates_presence_of :review_body
  belongs_to :book
end
