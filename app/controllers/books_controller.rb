class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    # @author = Author.new(params[:book][:author])
    # @author.save
    @book = Book.new(book_params)
    @book.save
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :page_count, :year_published, :thumbnail_url, authors_attributes: [:name])
  end
end
