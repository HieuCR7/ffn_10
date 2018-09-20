class Admin::UsersController < Admin::BaseController
  before_action :load_user, except: %i(index new create)

  def index
    @search = User.newest.ransack params[:q]
    @users = @search.result.page(params[:page]).per(Settings.user_per)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:info] = t ".create_success"
      redirect_to admin_users_path
    else
      flash[:danger] = t ".create_error"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:info] = t ".update_success"
      redirect_to admin_users_path
    else
      flash[:danger] = t ".update_error"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:info] = t ".destroy_success"
    else
      flash[:danger] = t ".destroy_error"
    end
    redirect_to admin_users_path
  end

  private

  def load_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user).permit :email, :fullname, :gender,
      :admin, :money, :password, :password_confirmation
  end
end
