require 'rails_helper'

RSpec.describe "when user visits book show page" do
  before :each do
    @css = Book.create(title: 'CSSucks', page_count: 420, year_published: 2019, thumbnail_url: 'https://i1.wp.com/www.developermemes.com/wp-content/uploads/2014/01/CSS-Sucks-TShirt-Meme.jpg?resize=385%2C232')
    @mockingbird = Book.create(title: 'To Kill a Mockingbird', page_count: 324, year_published: 1960, thumbnail_url: 'https://images.gr-assets.com/books/1552035043l/2657.jpg')
    @css.authors << Author.find_or_create_by(name: 'Matt Weiss')
    @css.authors << Author.find_or_create_by(name: 'Matt Levy')
    @mockingbird.authors << Author.find_or_create_by(name: 'Matt Levy')
  end

  it "should display author information" do
    visit author_path(@css.authors.last)

    expect(page).to have_content("#{@css.authors.last.name}")

    matts_first_book = @css.authors.last.books.first

    within "#id-#{matts_first_book.id}" do
      expect(page).to have_content(matts_first_book.title)
      expect(page).to have_content(matts_first_book.page_count)
      expect(page).to have_xpath("//img[@src='https://i1.wp.com/www.developermemes.com/wp-content/uploads/2014/01/CSS-Sucks-TShirt-Meme.jpg?resize=385%2C232']")
      expect(page).to have_content("Matt Weiss")
    end

    matts_second_book = @css.authors.last.books.last

    within "#id-#{matts_second_book.id}" do
      expect(page).to have_content(matts_second_book.title)
      expect(page).to have_content(matts_second_book.page_count)
      expect(page).to have_xpath("//img[@src='https://images.gr-assets.com/books/1552035043l/2657.jpg']")
    end
  end

  it "should allow users to delete authors" do
    visit author_path(@mockingbird.authors.last)

    expect(page).to have_link("Delete This Author")

    ml = @mockingbird.authors.last.name
    ml_2 = @css.authors.last.name
    click_link("Delete This Author")

    expect(current_path).to eq(books_path)
    expect(page).to_not have_content(@mockingbird.title)
    expect(page).to_not have_content(ml)
    expect(page).to_not have_content(@css.title)
    expect(page).to_not have_content(ml_2)
  end
end
