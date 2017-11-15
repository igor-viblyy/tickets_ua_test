class Admin::UsersController < Admin::BaseController
  layout 'layouts/admin_application'

  before_action :find_user, only: %i[edit update destroy]
  before_action :allow_without_password, only: [:update]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    # This is hack a new user from Devise gem
    sql = "insert into users (encrypted_password,email, created_at,updated_at) values(
        #{ActiveRecord::Base.connection.quote(user_params[:encrypted_password])},
        #{ActiveRecord::Base.connection.quote(user_params[:email])},now(), now())"
    ActiveRecord::Base.connection.execute(sql)
    redirect_to action: 'index'
  end

  def edit
  end

  def update
    if @user.update!(user_params)
      redirect_to admin_users_path, notice: 'User has updated'
    else
      render @edit, error: "Error #{error_notification}"
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: 'User is destroyed'
  end

  private
    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email,
                                   :encrypted_password,
                                   :reset_password_token,
                                   :reset_password_sent_at,
                                   :remember_created_at,
                                   :sign_in_count,
                                   :current_sign_in_at,
                                   :last_sign_in_at,
                                   :current_sign_in_ip,
                                   :last_sign_in_ip,
                                   :created_at,
                                   :updated_at,
                                   :password,
                                   :password_confirmation)
    end

    def allow_without_password
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      else
        @user.encrypted_password.crypt(user_params[:password])
      end
    end
end
