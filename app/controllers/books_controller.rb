class BooksController < ApplicationController
  def index
    @book_count = Book.all.count
    if params[:sort] == "highest_rated"
      @books = Book.best_books
    elsif params[:sort] == "lowest_rated"
      @books = Book.worst_books
    else
      @books = Book.all
    end
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

  def destroy
    book = Book.find(params[:id])
    book.reviews.each { |review| review.destroy }
    book.authors.each { |author| author.destroy if author.books.count == 1 }
    book.destroy
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
