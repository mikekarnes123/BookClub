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
    @astronaut.reviews.create_with(review_body: 'I guess they can if you take videos and post them on youtube', review_headline: 'In space, no one can hear you play guitar', review_score: 1).find_or_create_by(user: 'Space Good')
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

  it "has stats box with appropriate information" do
    #poorly rated book X 3
    hunger = Book.create(title: 'The Hunger Games', page_count: 374, year_published: 2008, thumbnail_url: 'https://images.gr-assets.com/books/1447303603l/2767052.jpg')
    hunger.authors << Author.find_or_create_by(name: 'Suzanne Collins')
    hunger.reviews.create_with(review_body: "Secrets From Batman", review_headline: "Hilarious Dental Care", review_score: "1").find_or_create_by(user: "CozyLittleBookJournal")
    hunger.reviews.create_with(review_body: "Save Trumpet Playing?", review_headline: "Can Martin Scorsese", review_score: "2").find_or_create_by(user: "Tex Montreal")
    hunger.reviews.create_with(review_body: "Make Psychologists Feel Ashamed", review_headline: "Shocking Things That", review_score: "1").find_or_create_by(user: "AmericaSolid")
    hunger.reviews.create_with(review_body: "Your Web Designer Feel More Attractive", review_headline: "Incredible Facts That Will Make", review_score: "2").find_or_create_by(user: "Dell MacApple")
    hunger.reviews.create_with(review_body: "Receptionists Won't Tell Their Friends", review_headline: "Staggering Things", review_score: "2").find_or_create_by(user: "Ed Bed")
    hunger.reviews.create_with(review_body: "Surprising Metallurgy Secrets", review_headline: "Ashton Kutcher's 15", review_score: "1").find_or_create_by(user: "Monica Labrador")
    farm = Book.create(title: 'Animal Farm', page_count: 122, year_published: 1945, thumbnail_url: 'https://images.gr-assets.com/books/1424037542l/7613.jpg')
    farm.authors << Author.find_or_create_by(name: 'George Orwell')
    farm.reviews.create_with(review_body: "That Will Make Your Urologist Sleepy", review_headline: "Frightening Secrets", review_score: "1").find_or_create_by(user: "CozyLittleBookJournal")
    farm.reviews.create_with(review_body: "About Pet Care", review_headline: "Awesome Facts", review_score: "1").find_or_create_by(user: "Tex Montreal")
    farm.reviews.create_with(review_body: "Fathers Nervous", review_headline: "Truths That Make", review_score: "1").find_or_create_by(user: "AmericaSolid")
    farm.reviews.create_with(review_body: "Secrets From Johnny Depp", review_headline: "Unbelievable Frisbee Golf", review_score: "1").find_or_create_by(user: "Stegosaurus Jones")
    farm.reviews.create_with(review_body: "Are Hiding From You", review_headline: "Secrets Spouses", review_score: "1").find_or_create_by(user: "Molly Popper")
    farm.reviews.create_with(review_body: "Incredible Microsoft Excel Tips", review_headline: "Julia Roberts's 15", review_score: "1").find_or_create_by(user: "Emma Stout")
    fellowship = Book.create(title: 'The Fellowship Of The Rings', page_count: 423, year_published: 1954, thumbnail_url: 'http://images.mentalfloss.com/sites/default/files/styles/width-constrained-728/public/507311-_amazon91jbdarvqml.jpg')
    fellowship.authors << Author.find_or_create_by(name: 'J.R.R. Tolkien')
    fellowship.reviews.create_with(review_body: "Mother Isn't Telling You", review_headline: "Scary Secrets Your", review_score: "1").find_or_create_by(user: "AmericaSolid")
    fellowship.reviews.create_with(review_body: "Supervisors Won't Tell You", review_headline: "Embarrassing Things", review_score: "1").find_or_create_by(user: "Dell MacApple")
    fellowship.reviews.create_with(review_body: "PowerPoint Tips From Brad Pitt", review_headline: "Little-Known", review_score: "1").find_or_create_by(user: "Demetrius Levenworth")
    fellowship.reviews.create_with(review_body: "Baristas Are Using Against You", review_headline: "Fascinating Things", review_score: "1").find_or_create_by(user: "Stegosaurus Jones")
    fellowship.reviews.create_with(review_body: "Grandmothers Work Harder", review_headline: "Facts That Make", review_score: "1").find_or_create_by(user: "Tex Montreal")
    fellowship.reviews.create_with(review_body: "Of Joke Writing", review_headline: "The Surprising Secrets", review_score: "1").find_or_create_by(user: "Monica Labrador")
    # one additional well rated book
    king = Book.create(title: 'The Return Of The King', page_count: 416, year_published: 1955, thumbnail_url: 'https://images-na.ssl-images-amazon.com/images/I/41Qx%2BidkxsL.jpg')
    king.authors << Author.find_or_create_by(name: 'J.R.R. Tolkien')
    king.reviews.create_with(review_body: " Waiters Sleepy", review_headline: "Facts That Make", review_score: "4").find_or_create_by(user: "Ronald Ward")
    king.reviews.create_with(review_body: "Will Never Admit", review_headline: "Truths Your Grandfather", review_score: "4").find_or_create_by(user: "AmericaSolid")
    king.reviews.create_with(review_body: "From Chris Pine", review_headline: "Surprising Tree Climbing Tips", review_score: "3").find_or_create_by(user: "Dell MacApple")
    king.reviews.create_with(review_body: "That Make Lawyers Angry", review_headline: "Amazing Truths", review_score: "3").find_or_create_by(user: "Demetrius Levenworth")
    king.reviews.create_with(review_body: "Will Make Your Local Politician Nervous", review_headline: "Mind-Blowing Secrets That", review_score: "2").find_or_create_by(user: "Ed Bed")
    king.reviews.create_with(review_body: "5 Mind-Blowing Angry Birds Tips", review_headline: "Netflix CEO Reed Hastings's", review_score: "5").find_or_create_by(user: "Stegosaurus Jones")

    visit books_path

    within(".book-stats-box") do
      within("#bestbooks") do
        expect(page).to have_content("The Return Of The King")
        expect(page).to have_content("An Astronaut's Guide To Life On Earth")
        expect(page).to have_content("Cs Sucks")
      end

      within("#worstbooks") do
        expect(page).to have_content("The Fellowship Of The Rings")
        expect(page).to have_content("Animal Farm")
        expect(page).to have_content("The Hunger Games")
      end
    end
  end

  it "can sort by average rating" do
    @css.reviews.create_with(review_body: "Thinks About In The Bathroom", review_headline: "Facts Your Elected Official", review_score: "5").find_or_create_by(user: "Stegurus Jones")

    visit books_path
    click_on "Highest Rated"

    expect(page.all("div")[0]).to have_content(@css.title)
    expect(page.all("div")[1]).to have_content(@astronaut.title)


    visit books_path
    click_on "Lowest Rated"

    expect(page.all("div")[0]).to have_content(@astronaut.title)
    expect(page.all("div")[1]).to have_content(@css.title)
  end

  it "can sort by page count" do

    visit books_path

    click_on "Most Pages"

    expect(page.all("div")[0]).to have_content(@css.title)
    expect(page.all("div")[1]).to have_content(@astronaut.title)


    visit books_path
    click_on "Least Pages"

    expect(page.all("div")[0]).to have_content(@astronaut.title)
    expect(page.all("div")[1]).to have_content(@css.title)
  end
end
