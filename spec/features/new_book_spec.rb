require 'rails_helper'

RSpec.describe "book creation workflow" do
  it "allows user to create new book" do
    visit new_book_path
    fill_in 'book[title]', with: "Life Will Be the Death of Me"
    fill_in 'book[page_count]', with: 325
    fill_in 'book[year_published]', with: "2019"
    fill_in "authors[name]", with: "Chelsea Handler"
    fill_in 'book[thumbnail_url]', with: "google.com"
    click_on "Add Book"

    expect(current_path).to eq(books_path)

    new_book = Book.find_by(title: "Life Will Be the Death of Me")
    new_author = new_book.authors.last

    expect(page).to have_content(new_book.title)
    expect(page).to have_content(new_book.page_count)
    expect(page).to have_content(new_book.year_published)
    expect(page).to have_content(new_author.name)
  end

  it "sad path default image" do
    visit new_book_path

    fill_in 'book[title]', with: "Life Will Be the Death of Me"
    fill_in 'book[page_count]', with: 325
    fill_in 'book[year_published]', with: "2019"
    fill_in "authors[name]", with: "Chelsea Handler"
    click_on "Add Book"

    expect(current_path).to eq(books_path)

    new_book = Book.find_by(title: "Life Will Be the Death of Me")
    new_author = new_book.authors.last
    
    within("#id-#{new_book.id}") do
      expect(page).to have_content(new_book.title)
      expect(page).to have_content(new_book.page_count)
      expect(page).to have_content(new_book.year_published)
      expect(page).to have_content(new_author.name)
      expect(page).to have_css("img[src='http://clipart-library.com/images/6Tpo6G8TE.jpg']")
    end

  end
end
