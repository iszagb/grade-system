class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy grades courses ]
  before_action :authenticate_user!
  before_action :check_admin, only: [:index, :destroy]

  def index
    @students = Student.all
  end

  def dashboard
    redirect_to edit_student_path(current_user.student) if current_user.student.first_name.blank?
    @student = current_user.student
    @courses = current_user.student.courses
  end

  def show; end

  def search
    @students = Student.search(params[:search])
  end

  def courses
  end

  def grades
    @student_courses = @student.student_courses
  end

  def new
    @student = Student.new
  end

  def edit; end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to @student, notice: "Student was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @student.update(student_params)
      if current_user.student?
        redirect_to dashboard_students_path, notice: "Profile updated successfully."
      else
        redirect_to @student, notice: "Student updated successfully."
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @student.destroy!

    redirect_to students_url, notice: "Student was successfully destroyed."
  end

  private
    def set_student
      @student = Student.find(params[:id])
    end

    def student_params
      params.require(:student).permit(:first_name, :last_name)
    end

    def check_admin
      redirect_to root_path, alert: "Unauthorized access!" unless current_user.admin?
    end
end
