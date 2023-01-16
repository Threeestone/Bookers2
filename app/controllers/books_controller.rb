class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
     redirect_to book_path
    else
     render :new
    end
  end

  def index
    @books = book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def destroy
    @book = Book.destroy
    @book.destroy
    redirect_to book_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :opinion)
  end
end