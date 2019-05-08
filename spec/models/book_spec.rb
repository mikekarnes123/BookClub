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
    describe '#author_list' do
      it "should return full author list" do
        hunger = Book.create(title: 'The Hunger Games', page_count: 374, year_published: 2008, thumbnail_url: 'https://images.gr-assets.com/books/1447303603l/2767052.jpg')
        hunger.authors << Author.find_or_create_by(name: 'Suzanne Collins')
        hunger.authors << Author.find_or_create_by(name: 'Carrie Walsh')

        expected = "Suzanne Collins, Carrie Walsh"
        actual = hunger.author_list

        expect(expected).to eq(actual)
      end
    end
  end 
end
