class CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy assign_student students grade_student ]

  def index
    @courses = Course.all
  end

  def show
  end

  def new
    @course = Course.new
  end

  def assign_student
    @searched_students = Student.search(params[:search])
  end

  def students
  end

  def grade_student
    @course = Course.find(params[:course_id])
    @student = Student.find(params[:student_id])
    @grade = Grade.new
  end

  def assign_student_grade
    @course = Course.find(params[:grade][:course_id])
    @student = Student.find(params[:grade][:student_id])
    @student_course = @student.student_courses.where(course_id: @course.id).first
    @grade = @student_course.grades.new(grade_params)

    if @grade.save
      redirect_to @course, notice: 'Grade assigned successfully.'
    else
      render :grade_student
    end
  end
  def assign_student_to_course
    @course = Course.find(params[:course_id])
    student = Student.find(params[:student_id])
    if @course.students.include?(student)
      redirect_to course_path(@course), notice: "cannot add student, #{student.first_name} is already assigned to the course."
    else
      @course.students << student
      redirect_to course_path(@course), notice: "#{student.first_name} assigned to the course successfully."
    end
  end

  def edit
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to @course, notice: "Course was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @course.update(course_params)
      redirect_to @course, notice: "Course updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @course.destroy!

    redirect_to courses_url, notice: "Course was successfully destroyed."
  end

  private
    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:name, :year)
    end

    def grade_params
      params.require(:grade).permit(:score, :quarter)
    end
end
