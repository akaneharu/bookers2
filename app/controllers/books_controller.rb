class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Created Book successfully!"
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.includes(:user).all
      render "index"
    end
  end


  def index
    @user = current_user
    @book = Book.new
    @books = Book.includes(:user).all
  end

  def show
    @post = Book.new
    @book = Book.includes(:user).find(params[:id])
    @user = User.find(@book.user_id)
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully"
      redirect_to book_path(@book.id)
    else
      render "edit"
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

   def book_params
     params.require(:book).permit(:title, :body)
   end

   def is_matching_login_user
     book = Book.find(params[:id])
     unless book.user_id == current_user.id
       redirect_to books_path
     end
   end

end
