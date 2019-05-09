require 'rails_helper'

RSpec.describe "new review workflow" do
  it "allows user to add review" do
    king = Book.create(title: 'The Return Of The King', page_count: 416, year_published: 1955, thumbnail_url: 'https://images-na.ssl-images-amazon.com/images/I/41Qx%2BidkxsL.jpg')
    visit new_book_review_path(king)

    fill_in 'review[user]', with: "Brian"
    fill_in 'review[review_headline]', with: "Great read"
    fill_in 'review[review_score]', with: 4
    fill_in 'review[review_body]', with: "It was great."
    click_on "Add Review"

    review = king.reviews.last

    within(".reviews") do
      within("#id-#{review.id}") do
        expect(page).to have_content(review.user)
        expect(page).to have_content(review.review_headline)
        expect(page).to have_content(review.review_score)
        expect(page).to have_content(review.review_body)
      end
    end
  end
end
