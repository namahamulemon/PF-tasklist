class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  def new
     @user = User.new
  end

  def index
  @q = User.ransack(params[:q])
  @users = @q.result(distinct: true)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = '社員情報が登録されました'
      redirect_to admin_users_path
    else
      flash[:danger] = '社員情報が登録されません'
      render :new
    end
  end

  def show
     @user = User.find(params[:id])
  @q = User.ransack(params[:q])
  @users = @q.result(distinct: true)
  end

  def edit
     @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

   if @user.update(user_params)
    flash[:success] = '社員情報が更新されました'
    redirect_to admin_users_path
   else
    flash.now[:danger] = '社員情報の更新に失敗しました'
    render :edit
   end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :name_kana, :name_pass, :password, :is_active)
  end

end
