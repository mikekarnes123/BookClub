class Book < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :page_count
  validates_presence_of :thumbnail_url
  validates_presence_of :year_published
  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :reviews

  def author_list
    authors.pluck(:name).join(', ')
  end

  def multiple_authors?
    return true if authors.count > 1
    false
  end

  def authors_except(author_to_exclude)
    authors.where.not(name: author_to_exclude).pluck(:name).join(', ')
  end
end
