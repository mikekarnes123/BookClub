require 'rails_helper'

RSpec.describe "when user visits book index" do
  before :each do
    @astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", page_count: 284, year_published: 2013, thumbnail_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
    @css = Book.create(title: 'CSSucks', page_count: 420, year_published: 2019, thumbnail_url: 'https://i1.wp.com/www.developermemes.com/wp-content/uploads/2014/01/CSS-Sucks-TShirt-Meme.jpg?resize=385%2C232')
    @astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')
    @css.authors << Author.find_or_create_by(name: 'Matt Weiss')
    @css.authors << Author.find_or_create_by(name: 'Matt Levy')
  end

  it "displays all book information" do
    visit books_path

    within("#id-#{@astronaut.id}") do
      expect(page).to have_content("Title: #{@astronaut.title}")
      expect(page).to have_content("Author(s): #{@astronaut.authors.last.name}")
      expect(page).to have_content("Page Count: #{@astronaut.page_count}")
      expect(page).to have_content("Year Published: #{@astronaut.year_published}")
      expect(page).to have_xpath("//img[@src='http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg']")
    end

    within("#id-#{@css.id}") do
      expect(page).to have_content("Title: #{@css.title}")
      expect(page).to have_content("Author(s): #{@css.authors.first.name} #{@css.authors.last.name}")
      expect(page).to have_content("Page Count: #{@css.page_count}")
      expect(page).to have_content("Year Published: #{@css.year_published}")
      expect(page).to have_xpath("//img[@src='https://i1.wp.com/www.developermemes.com/wp-content/uploads/2014/01/CSS-Sucks-TShirt-Meme.jpg?resize=385%2C232']")
    end
  end

  it "allows user to click on title of book" do
    visit books_path

    click_on(@astronaut.title)
    expect(current_path).to eq(book_path(@astronaut))

    visit books_path

    click_on(@css.title)
    expect(current_path).to eq(book_path(@css))
  end

  it "allows user to click on author of book" do
    visit books_path

    click_on(@astronaut.authors.last.name)
    expect(current_path).to eq(author_path(@astronaut.authors.last))

    visit books_path

    click_on(@css.authors.last.name)
    expect(current_path).to eq(author_path(@css.authors.last))

    visit books_path

    click_on(@css.authors.first.name)
    expect(current_path).to eq(author_path(@css.authors.first))
  end


end
