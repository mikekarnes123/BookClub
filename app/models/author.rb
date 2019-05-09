class Author < ApplicationRecord
  validates_presence_of :name
  has_many :book_authors
  has_many :books, through: :book_authors
  before_save :title_casing


  def title_casing
    self.name = name.titlecase
  end
end
