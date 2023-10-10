class BooksController < ApplicationController
  before_action :ensure_current_user, only: [:edit,:update,:destroy]

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
      if @book.save
        flash[:notice] = "You have created book successfully."
        redirect_to book_path(@book.id)
      else
        @books = Book.all
        flash.now[:alert] = "errors prohibited this obj from being saved:"
        render :index
      end
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @user = current_user
    @book = Book.find(params[:id])
    @users = User.all
    @books = Book.all
    @book_new = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      flash[:alert] = "You don't have permission to edit this book"
      redirect_to books_path
    end
  end


  def update
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
      return
    end
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to  book_path(@book.id)
    else
      @books = Book.all
      flash.now[:alert] = "Failed to update the book."
      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    if @book.user_id == current_user.id
      @book.destroy
      flash[:notice] = "Book has been deleted successfully."
    else
      flash[:alert] = "You don't have permission to delete this book."
    end
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end

  def ensure_current_user
    @book = Book.find(params[:id])
     if @book.user_id != current_user.id
        redirect_to books_path
     end
  end
end