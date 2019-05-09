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
    @book = Book.new(book_params)
    if @book.save
      @book.authors.create(author_params)
    end
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :page_count, :year_published, :thumbnail_url)
  end

  def author_params
    params.require(:authors).permit(:name)
  end
end
