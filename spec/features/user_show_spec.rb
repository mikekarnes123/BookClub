require 'rails_helper'

RSpec.describe "user showpage" do
    before :each do
      @astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", page_count: 284, year_published: 2013, thumbnail_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
      @astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')
      @astronaut.reviews.create_with(review_body: 'I guess they can if you take videos and post them on youtube', review_headline: 'In space, no one can hear you play guitar', review_score: 4).find_or_create_by(user: 'Space Good')
      @css = Book.create(title: 'CSSucks', page_count: 420, year_published: 2019, thumbnail_url: 'https://i1.wp.com/www.developermemes.com/wp-content/uploads/2014/01/CSS-Sucks-TShirt-Meme.jpg?resize=385%2C232')
      @css.authors << Author.find_or_create_by(name: 'Matt Weiss')
      @css.authors << Author.find_or_create_by(name: 'Matt Levy')
      @css.reviews.create_with(review_body: "Thinks About In The Bathroom", review_headline: "Facts Your Elected Official", review_score: "3").find_or_create_by(user: "Space Good")

    end

  it "shows visitors a users page with all reviews of books" do
    visit book_path(@astronaut)

    click_link('Space Good')
    expect(current_path).to eq(user_path(@astronaut.reviews.last.user))

    expect(page).to have_content(@astronaut.reviews.last.review_headline)
    expect(page).to have_content(@astronaut.reviews.last.review_body)
    expect(page).to have_content(@astronaut.reviews.last.review_score)
    expect(page).to have_content(@astronaut.reviews.last.created_at)
    expect(page).to have_content(@astronaut.title)
    expect(page).to have_xpath("//img[@src='http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg']")

    expect(page).to have_content(@css.title)
    expect(page).to have_content(@css.reviews.last.review_headline)
  end
end
