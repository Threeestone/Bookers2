class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]

  def index
    @book = Book.new
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
   user_id = params[:id].to_i
   unless user_id == current_user.id
    redirect_to user_path(@user.id)
   end
    @user = User.find(params[:id])
  end

  def update

    user_id = params[:id].to_i
    unless user_id == current_user.id
    redirect_to user_path(@user.id)
    end

    @user = User.find(params[:id])
    if @user.update(user_params)
     flash[:notice] = "You have updated user successfully"
    redirect_to user_path(@user.id)
    else
    render :edit
    end
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
