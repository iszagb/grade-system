class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def dashboard
  end

  def students
    @students = Student.all
  end

  def new_user
    @user = User.new
  end

  def create_user
    @user = User.new(user_params)
    if @user.save
      Student.create(user: @user, first_name: params[:student][:first_name], last_name: params[:student][:last_name]) if params[:user][:role] == 'student'
      redirect_to admin_dashboard_path, notice: 'User created successfully.'
    else
      render :new_user
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role, student_attributes: [:first_name, :last_name])
  end

  def check_admin
    redirect_to root_path, alert: "Unathorized" unless current_user.admin?
  end
end
