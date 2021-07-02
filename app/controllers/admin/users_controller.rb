class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :exclude_not_admin_user

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user), notice: "ユーザー「#{@user.name}」を登録しました"
    else
      render :new
    end
  end

  def index
    @users = User.all.includes(:tasks)
  end
  
  def edit
  end
  def update
    @user.update(user_params)
    redirect_to admin_users_path, notice:"ユーザー「#{@user.name}」の権限を更新しました"
  end
  def show
  end
  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を削除しました"
    else
      redirect_to admin_users_path, notice: "ユーザー「#{@user.name}」を削除できませんでした"
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end
  def set_user
    @user = User.find(params[:id])
  end
  def exclude_not_admin_user
    if current_user.admin == false
      redirect_to root_path, notice: 'アクセス権限がありません'
    end
  end
end
