class Book < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :page_count
  validates_presence_of :thumbnail_url
  validates_presence_of :year_published
  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :reviews
end
