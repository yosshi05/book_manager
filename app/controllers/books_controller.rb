class BooksController < ApplicationController
  # ▼ 1. アプリ全体で「ログイン必須」にします（ログインしてないと画面が開けなくなります）
  before_action :authenticate_user!
  
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    # ▼ 2. Book.all から「現在ログインしているユーザー（current_user）の書籍だけ」に変更
    @books = current_user.books

    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename=\"books_list_#{Time.current.strftime('%Y%m%d')}.xlsx\""
      }
    end
  end

  def show
  end

  def new
    # ▼ 3. 空のBookを作るときも、ログインユーザーに関連付けたものを作ります
    @book = current_user.books.build
  end

  def edit
  end

  def create
    # ▼ 4. 保存するときも、ログインユーザーに関連付けて保存します
    @book = current_user.books.build(book_params)
    if @book.save
      redirect_to books_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      redirect_to book_path(@book)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path, status: :see_other
  end

  private

  def set_book
    # ▼ 5. 他のユーザーの本をURL直打ちで盗み見られないよう、自分の本から探す制限をかけます
    @book = current_user.books.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :status, :progress, :memo)
  end
end