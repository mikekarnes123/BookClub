class Book < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :page_count
  validates_presence_of :thumbnail_url
  validates_presence_of :year_published
  has_many :book_authors
  has_many :authors, through: :book_authors, dependent: :destroy
  has_many :reviews
  after_initialize :set_defaults
  before_save :title_casing

  def author_list
    authors.pluck(:name).join(', ')
    # binding.pry
  end

  def multiple_authors?
    return true if authors.count > 1
    false
  end

  def authors_except(author_to_exclude)
    authors.where.not(name: author_to_exclude).pluck(:name).join(', ')
  end

  def set_defaults
    if thumbnail_url == ""
      self.thumbnail_url = "http://clipart-library.com/images/6Tpo6G8TE.jpg"
    end
  end

  def title_casing
    self.title = title.titlecase
  end
end
