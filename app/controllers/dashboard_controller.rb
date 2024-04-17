class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    case current_user.role
    when 'admin'
      redirect_to admin_dashboard_path
    when 'student'
      redirect_to dashboard_students_path
    end
  end
end
