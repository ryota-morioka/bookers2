class BooksController < ApplicationController
  def index
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = current_user.books.new(book_params)
    @book.save
    redirect_to books_path
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
  end

  def edit
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
