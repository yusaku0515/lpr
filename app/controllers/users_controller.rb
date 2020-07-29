class UsersController < ApplicationController
  before_action :authenticate_user! # ログインしていないと見れない　アクセス権限

  def signup2
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: params[:id]).page(params[:page]).per(6)
  end

  def edit
    @user = User.find(params[:id])
    if @user.id == current_user.id
      render 'edit'
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if params[:user][:member_status] == "false" # 退会用の記述
      @user.user_status = false
      @user.update(user_params)
      reset_session # ログアウト
      redirect_to root_path
      return # ここから下は実行されない
    else
      if @user.update(user_params) # 会員登録情報の編集用記述
        redirect_to user_path(@user.id)
      else # エラーメッセージ表示用
        render 'edit'
        end
    end
  end

  def leave
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:family_name, :first_name, :age, :icon_image, :introduction, :postal_code, :company_name, :address, :phone_number, :hp_url, :member_status, :user_status)
  end
end
