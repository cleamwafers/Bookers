class BooksController < ApplicationController
protect_from_forgery
  def new
    @book = Book.new
  end
  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    # 3. データをデータベースに保存するためのsaveメソッド実行
   if @book.save
    redirect_to book_path(@book.id), notice: "Book was successfully created."
    else
      @books = Book.all
      render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new

  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def destroy
    @book = Book.find(params[:id])  # データ（レコード）を1件取得
    @book.destroy # データ（レコード）を削除
    redirect_to books_path, notice: "Book was successfully destroyed."
  
  end

  def update
    @book = Book.find(params[:id])
    # 編集ページの送信ボタンから飛んできたときのparamsに格納されたidを元に、該当する投稿データを探して、変数に代入する
    if @book.update(book_params)
     redirect_to book_path(@book.id), notice: "Book was successfully updated."
    else
     flash.now[:danger] = "error"
     @books = Book.all
     render :index
   end
  end

  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
end