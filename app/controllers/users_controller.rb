class UsersController < ApplicationController

  def show
    # @book = Book.all
    @user = User.find(params[:id])
    # @books = @user.books
    @books = @user.books.page(params[:page])
    
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end
  
  def index
    # @user = User.find(params[:id])
    @user = User.find(current_user.id)
    @books = @user.books.page(params[:page])
  end
  
  def list
    @user = User.find(current_user.id)
    @users = User.all
    @books = Book.page(params[:page])
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
  
  def book_params
    params.require(:book).permit(:title, :body)
  end

end