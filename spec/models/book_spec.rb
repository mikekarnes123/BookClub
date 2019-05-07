require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'Relationships' do
    it {should have_many :reviews}
    it {should have_many :book_authors}
    it {should have_many(:authors).through(:book_authors)}
    it {should validate_presence_of :title}
    it {should validate_presence_of :page_count}
    it {should validate_presence_of :year_published}
    it {should validate_presence_of :thumbnail_url}
  end
end
