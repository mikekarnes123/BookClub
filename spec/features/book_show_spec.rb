require 'rails_helper'

RSpec.describe "when user visits book show page" do
  before :each do
    @css = Book.create(title: 'CSSucks', page_count: 420, year_published: 2019, thumbnail_url: 'https://i1.wp.com/www.developermemes.com/wp-content/uploads/2014/01/CSS-Sucks-TShirt-Meme.jpg?resize=385%2C232')
    @css.authors << Author.find_or_create_by(name: 'Matt Weiss')
    @css.authors << Author.find_or_create_by(name: 'Matt Levy')
    @css.reviews.create_with(review_body: "Make Your Psychiatrist Go To The Gym More", review_headline: "Scary Truths That Will", review_score: "1").find_or_create_by(user: "CozyLittleBookJournal")
    @css.reviews.create_with(review_body: "Agriculture Secretary Thomas J. Vilsack", review_headline: "Photoshop Tips From", review_score: "2").find_or_create_by(user: "Ronald Ward")
  end

  it "should display book information" do
    visit book_path(@css)

    within("#id-#{@css.id}") do
      expect(page).to have_content("Title: #{@css.title}")
      expect(page).to have_content("Author(s): #{@css.authors.first.name}, #{@css.authors.last.name}")
      expect(page).to have_content("Page Count: #{@css.page_count}")
      expect(page).to have_content("Year Published: #{@css.year_published}")

      expect(page).to have_xpath("//img[@src='https://i1.wp.com/www.developermemes.com/wp-content/uploads/2014/01/CSS-Sucks-TShirt-Meme.jpg?resize=385%2C232']")
    end
  end

  it "should display all reviews" do
    visit book_path(@css)

    within(".reviews") do
      within("#id-#{@css.reviews.first.id}") do
        expect(page).to have_content("User: #{@css.reviews.first.user}")
        expect(page).to have_content("Title: #{@css.reviews.first.review_headline}")
        expect(page).to have_content("Rating: #{@css.reviews.first.review_score}")
        expect(page).to have_content("Review: #{@css.reviews.first.review_body}")
      end

      within("#id-#{@css.reviews.last.id}") do
        expect(page).to have_content("User: #{@css.reviews.last.user}")
        expect(page).to have_content("Title: #{@css.reviews.last.review_headline}")
        expect(page).to have_content("Rating: #{@css.reviews.last.review_score}")
        expect(page).to have_content("Review: #{@css.reviews.last.review_body}")
      end
    end
  end
end
