class BooksController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book succesfully."
     redirect_to book_path(@book.id)
    else
     @user = current_user
     @books = Book.all
     render :index
    end
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
    @book_new = Book.new
    @user = current_user
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
     flash[:notice] = "You have updated book succesfully"
    end
    redirect_to book_path(@book.id)
  end

  def destroy
    @book = Book.destroy
    @book.destroy
    redirect_to book_path
  end

  private

  def book_params
    params.require(:book).permit(:title,:body,:image)
  end
end
