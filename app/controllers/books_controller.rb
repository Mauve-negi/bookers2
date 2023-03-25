class BooksController < ApplicationController
  
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to books_path
    else
      render :new
    end
  end

  def index
    @user = User.find(current_user.id)
    @books = Book.page(params[:page])
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = User.find(@book.user.id)
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to '/books'
  end
  
  def edit
    @book = Book.find(params[:id])
    @user = User.find(current_user.id)
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id)
      flash[:notice] = "Book was successfully updated."
    else
      @books = Book.all
      render :edit
    end
  end
  
  # 投稿データのストロングパラメータ
  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end
