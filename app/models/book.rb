class Book < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :page_count
  validates_presence_of :thumbnail_url
  validates_presence_of :year_published
  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :reviews
  accepts_nested_attributes_for :authors

  def author_list
    authors.pluck(:name).join(', ')
  end

  def multiple_authors?
    return true if authors.count > 1
    false
  end
  ###consider refactor
  def authors_except(author_to_exclude)
    unq_authors = authors.pluck(:name)
    unq_authors.delete(author_to_exclude)
    unq_authors.join(', ')
  end
end
