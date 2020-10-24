class BooksController < ApplicationController
  def index
    @books = Book.all
    @book = Book.new
    @users = User.all
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def new
  end

  def edit
     @user = User.find(params[:id])
  end

  def create
    @books = Book.all
    # @book = Book.new(book_params)

    if @book.save
      flash[:notice] = 'Book was successfully created.'
        redirect_to book_path(@book.id)# 条件がtrueだったら処理1を行う
    else
        render("books/index") # 条件がfalseだったら処理2を行う
    end

  end
  
  def update
    @book = Book.find(params[:id])
     if  @book.update(book_params)
      flash[:notice] = 'Book was successfully created.'
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

end
