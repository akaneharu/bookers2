class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @user = current_user
    @users = User.all
    @book = Book.new
  end
  
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have update user successfully"
      redirect_to user_path(@user.id)
    else
      render "edit"
    end  
  end

  # def create
  #   @book = Book.new(book_params)
  #   @book.user_id = current_user.id
  #   if @book.save
  #     flash[:notice] = "Created Book Successfully!"
  #     redirect_to book_path(@book.id)
  #   else
  #     flash[:alert] = "Creatrd book error"
  #     render :new
  #   end

  #   flash[:notice] = "You have signed up successfully!"
  #   redirect_to user_path(@user.id)
  # end

  private

   def user_params
     params.require(:user).permit(:name, :introduction, :profile_image)
   end
   
   def is_matching_login_user
     user = User.find(params[:id])
     unless user.id == current_user.id
       redirect_to user_path(current_user.id)
     end  
   end  

end
