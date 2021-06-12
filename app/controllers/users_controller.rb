class UsersController < ApplicationController
# 投稿した本人だけが、投稿した本文の編集や削除ができるという制限をかけるには3つの操作が必要である。
# 1. ユーザがログイン済みかどうか。before_action :authenticate_user!
# 2. ログインしたユーザが投稿した本人かどうかview内で表示を分ける。
# 3. ログインしたユーザが投稿した本人かどうかをcontrollerで分ける def ensure_correct_user ~  unless @user == current_user



  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :edit]

  def create
   @user = User.new(user_params)
   @user.user_id = current_user.id
   @user.save
   redirect_to book_path(@book.id)
  end

  def show
    # Parameters: {"id"=>"3"}
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    # Book.find(params[:id])
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def follow
    @following_users = current_user.following_user
  end

  def follower
    @follower_users = current_user.follower_user
  end


  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end