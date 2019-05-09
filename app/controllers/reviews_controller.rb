class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @book = Book.find(params[:book_id])
  end

  def create
    book = Book.find(params[:book_id])
    if book.reviews.pluck(:user).include?(review_params[:user])
      redirect_to book_path(book)
    elsif !book.reviews.pluck(:user).include?(review_params[:user])
      book.reviews.create(review_params)
      redirect_to book_path(book)
    end
  end

  private

  def review_params
    params.require(:review).permit(:user, :review_headline, :review_body, :review_score)
  end
end
