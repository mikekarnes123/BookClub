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
      expect(page).to have_link(@css.authors.first.name)
      expect(page).to have_link(@css.authors.last.name)
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
  it 'has book deletion functionality' do
    visit book_path(@css)

    css_title = @css.title

    click_on("Delete Book")


    expect(current_path).to eq(books_path)
    expect(page).to_not have_content(css_title)
  end

  it 'has stats box' do
    @css.reviews.create_with(review_body: "Agriculture Secretary Thomas J. Vilsack", review_headline: "A", review_score: "5").find_or_create_by(user: "RACSCDrd")
    @css.reviews.create_with(review_body: "Agriculture Secretary Thomas J. Vilsack", review_headline: "B", review_score: "5").find_or_create_by(user: "RACSrd")
    @css.reviews.create_with(review_body: "Agriculture Secretary Thomas J. Vilsack", review_headline: "C", review_score: "5").find_or_create_by(user: "RDrd")
    @css.reviews.create_with(review_body: "Agriculture Secretary Thomas J. Vilsack", review_headline: "a", review_score: "1").find_or_create_by(user: "rd")
    @css.reviews.create_with(review_body: "Agriculture Secretary Thomas J. Vilsack", review_headline: "b", review_score: "1").find_or_create_by(user: "CCDrd")
    @css.reviews.create_with(review_body: "Agriculture Secretary Thomas J. Vilsack", review_headline: "c", review_score: "1").find_or_create_by(user: "Drd")

    visit book_path(@css)

    within(".stats-box") do
      within("#bestreviews") do
        expect(page).to have_content("A")
        expect(page).to have_content("5")
        expect(page).to have_content("RACSCDrd")
        expect(page).to have_content("B")
        expect(page).to have_content("C")

      end

      within("#worstreviews") do
        expect(page).to have_content("a")
        expect(page).to have_content("1")
        expect(page).to have_content("rd")
        expect(page).to have_content("b")
        expect(page).to have_content("c")
      end

      within("#averagerating") do
        expect(page).to have_content("Average Rating: 3")
      end
    end
  end
end
