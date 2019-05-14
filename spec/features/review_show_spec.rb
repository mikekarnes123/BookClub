# require 'rails_helper'
#
# RSpec.describe "when visitor views review show page" do
#   it "should allow visitor to click on user name" do
#     visit review_path
#
#     @css = Book.create(title: 'CSSucks', page_count: 420, year_published: 2019, thumbnail_url: 'https://i1.wp.com/www.developermemes.com/wp-content/uploads/2014/01/CSS-Sucks-TShirt-Meme.jpg?resize=385%2C232')
#     @css.authors << Author.find_or_create_by(name: 'Matt Weiss')
#     @css.authors << Author.find_or_create_by(name: 'Matt Levy')
#     review_1 = @css.reviews.create_with(review_body: "Make Your Psychiatrist Go To The Gym More", review_headline: "Scary Truths That Will", review_score: "1").find_or_create_by(user: "CozyLittleBookJournal")
#     review_2 = @css.reviews.create_with(review_body: "Agriculture Secretary Thomas J. Vilsack", review_headline: "Photoshop Tips From", review_score: "2").find_or_create_by(user: "Ronald Ward")
#     review_3 = @css.reviews.create_with(review_body: "Ernest Moniz Save Skin Care?", review_headline: "Will Energy Secretary", review_score: "5").find_or_create_by(user: "Ed Bed")
#     review_4 = @css.reviews.create_with(review_body: "Thinks About In The Bathroom", review_headline: "Facts Your Elected Official", review_score: "3").find_or_create_by(user: "Stegosaurus Jones")
#   end
# end
