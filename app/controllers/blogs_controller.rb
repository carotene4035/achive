class BlogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_blog, only: [:edit, :update, :destroy, :show]
  # 表示用メソッド
  def index
    @blogs = Blog.all
  end
  
  def show
    # 入力フォーム用
    @comment = @blog.comments.build
    # 一覧用
    @comments = @blog.comments
  end

  
  def new
    if params[:back]
      @blog = Blog.new(blogs_params)
    else
      @blog = Blog.new
    end
  end

  def edit
  end
  
  # 処理呼び出し用メソッド
  def create
    @blog = Blog.new(blogs_params)
    @blog.user_id = current_user.id
    if @blog.save
      redirect_to blogs_path, notice: "ブログを作成しました!"
      NoticeMailer.sendmail_blog(@blog).deliver
    else
      render 'new'
    end
  end
  
  def update
    if @blog.update(blogs_params)
      redirect_to blogs_path, notice: "ブログを編集しました!"
      raise
    else
      render 'edit'
    end
  end
  
  def destroy
    # インスタンス変数に代入するのはなぜか
    # 普通の変数ではダメなのか
    @blog.destroy
    redirect_to blogs_path, notice: "ブログを削除しました!"
  end
  
  def confirm
    @blog = Blog.new(blogs_params)
    render :new if @blog.invalid?
  end
 
 private
 
 def blogs_params
   # 必要なパラメータのみを安全に切り取る
   # それがストロングパラメータ
   params.require(:blog).permit(:title, :content)
 end
 
 def set_blog
   @blog = Blog.find(params[:id])
 end
end
