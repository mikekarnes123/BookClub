require 'rails_helper'

RSpec.describe "when user visits book index" do
  before :each do
    @astronaut = Book.create(title: "An Astronaut's Guide to Life on Earth", page_count: 284, year_published: 2013, thumbnail_url: 'http://media.npr.org/assets/bakertaylor/covers/a/an-astronauts-guide-to-life-on-earth/9780316253017_custom-72b5b1e3d259fb604fee1401424db3c8cd04cfe0-s6-c30.jpg')
    @css = Book.create(title: 'CSSucks', page_count: 420, year_published: 2019, thumbnail_url: 'https://i1.wp.com/www.developermemes.com/wp-content/uploads/2014/01/CSS-Sucks-TShirt-Meme.jpg?resize=385%2C232')
    @astronaut.authors << Author.find_or_create_by(name: 'Chris Hadfield')
    @css.authors << Author.find_or_create_by(name: 'Matt Weiss')
    @css.authors << Author.find_or_create_by(name: 'Matt Levy')
    @astronaut.reviews.create_with(review_body: "I have so many good things to say about this book I don't think they'll all fit into one review (for my full review, including my four-year-old's reaction to it, please visit my blog, Cozy Little Book Journal).", review_headline: 'I have so many good things to say about this book', review_score: 5).find_or_create_by(user: 'CozyLittleBookJournal')
    @astronaut.reviews.create_with(review_body: "Have you ever wanted to know the life of an astronaut? How do you even get to be one? What do they do, especially when on earth? Why do they even do it? And how do you combine that with having a family? This wonderful new book will tell you all about it.", review_headline: 'Have you ever wanted to know the life of an astronaut?', review_score: 5).find_or_create_by(user: 'Anonymous')
    @astronaut.reviews.create_with(review_body: 'I hate space for some reason', review_headline: 'Boo Space', review_score: 2).find_or_create_by(user: 'Spacehater123')
    @astronaut.reviews.create_with(review_body: 'I also hate space for some reason', review_headline: 'Boo Space2', review_score: 1).find_or_create_by(user: 'Spacehater456')
    @astronaut.reviews.create_with(review_body: 'That was way more exciting', review_headline: "Wasn't The Martian based on a true story?", review_score: 3).find_or_create_by(user: 'Thatoneexgirlfriend')
    @astronaut.reviews.create_with(review_body: 'I guess they can if you take videos and post them on youtube', review_headline: 'In space, no one can hear you play guitar', review_score: 4).find_or_create_by(user: 'Space Good')
    @css.reviews.create_with(review_body: "Make Your Psychiatrist Go To The Gym More", review_headline: "Scary Truths That Will", review_score: "1").find_or_create_by(user: "CozyLittleBookJournal")
    @css.reviews.create_with(review_body: "Agriculture Secretary Thomas J. Vilsack", review_headline: "Photoshop Tips From", review_score: "2").find_or_create_by(user: "Ronald Ward")
    @css.reviews.create_with(review_body: "Keep To Themselves", review_headline: "Secrets Accountants", review_score: "3").find_or_create_by(user: "Dell MacApple")
    @css.reviews.create_with(review_body: "6 Practical Beard Care Tips", review_headline: "Scarlett Johansson's", review_score: "4").find_or_create_by(user: "Demetrius Levenworth")
    @css.reviews.create_with(review_body: "Ernest Moniz Save Skin Care?", review_headline: "Will Energy Secretary", review_score: "5").find_or_create_by(user: "Ed Bed")
    @css.reviews.create_with(review_body: "Thinks About In The Bathroom", review_headline: "Facts Your Elected Official", review_score: "3").find_or_create_by(user: "Stegosaurus Jones")

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

  it "displays number of reviews and average book rating" do
    visit books_path

    within("#id-#{@astronaut.id}") do
      expect(page).to have_content("Rating: 3")
    end

    within("#id-#{@css.id}") do
      expect(page).to have_content("Reviews: 6")
    end


  end

end
