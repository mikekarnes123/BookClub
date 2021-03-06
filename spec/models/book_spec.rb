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

  describe 'instance methods' do
    
    describe '#multiple_authors?' do
      it "should return true if multiple authors" do
        hunger = Book.create(title: 'The Hunger Games', page_count: 374, year_published: 2008, thumbnail_url: 'https://images.gr-assets.com/books/1447303603l/2767052.jpg')
        hunger.authors << Author.find_or_create_by(name: 'Suzanne Collins')

        expect(hunger.multiple_authors?).to eq(false)

        hunger.authors << Author.find_or_create_by(name: 'Carrie Walsh')

        expect(hunger.multiple_authors?).to eq(true)
      end
    end
    describe '#authors_except' do
      it "should return all authors except for current author" do
        hunger = Book.create(title: 'The Hunger Games', page_count: 374, year_published: 2008, thumbnail_url: 'https://images.gr-assets.com/books/1447303603l/2767052.jpg')
        hunger.authors << Author.find_or_create_by(name: 'Suzanne Collins')
        hunger.authors << Author.find_or_create_by(name: 'Stella Mainar')
        stella = hunger.authors.last

        expected = 'Suzanne Collins'

        expect(hunger.authors_except(stella.name)).to eq(expected)
      end
    end
  end
end
