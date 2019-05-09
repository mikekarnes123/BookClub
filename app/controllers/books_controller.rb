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
    @book = Book.find_or_create_by(book_params)
    if @book.save
      author_params[:name].split(', ').each do |author|
        @book.authors.find_or_create_by(name: author)
      end
      redirect_to books_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :page_count, :year_published, :thumbnail_url)
  end

  def author_params
    params.require(:authors).permit(:name)
  end
end
