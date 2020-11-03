class BooksController < ApplicationController

   before_action :authenticate_user!

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
  end

  def new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    if @book.save
      flash[:notice] = 'Book was successfully created.'
        redirect_to book_path(@book.id)# 条件がtrueだったら処理1を行う
    else
      @user = current_user
      @books = Book.all
        render 'index' # 条件がfalseだったら処理2を行う
    end

  end

  def update
    @book = Book.find(params[:id])
     if  @book.update(book_params)
      flash[:notice] = 'You have updated book successfully.'
        redirect_to book_path(@book.id)# 条件がtrueだったら処理1を行う
     else
        render "edit"# 条件がfalseだったら処理2を行う
     end
  end

  def destroy
    @book = Book.find_by(id: params[:id])
    @book.destroy
    redirect_to book_path
  end

  private

  def set_user
    @user = User.find([:id])
  end

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def user_params
    params.require(:user).permit(:profile_image, :name, :introduction)
  end

end
