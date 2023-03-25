class UsersController < ApplicationController

  def show
    # @book = Book.all
    @user = User.find(params[:id])
    # @books = @user.books
    @books = @user.books.page(params[:page])
    @book = Book.new
  end
  
  def edit
    @user = User.find(params[:id])
    
    if @user != current_user
      redirect_to user_path(current_user.id)
    end      
    
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
      flash[:notice] = "You have updated user successfully."
    else
      # @user = User.all
      render :edit
    end
  end

  def index
    # @user = User.find(params[:id])
    @user = User.find(current_user.id)
    @users = User.all
    @books = @user.books.page(params[:page])
    @book = Book.new
  end
  
  def list
    @user = User.find(current_user.id)
    @users = User.all
    @books = Book.page(params[:page])
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def book_params
    params.require(:book).permit(:title, :body)
  end

end