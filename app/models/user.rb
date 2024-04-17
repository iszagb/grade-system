class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { student: "student", teacher: "teacher", admin: "admin" }
  has_one :student
  after_commit :create_student_profile, on: [:create]

  def admin?
    role == "admin"
  end

  def student?
    role == 'student'
  end

  private

  def create_student_profile
    if student? && student.nil?
      Student.create(user: self)
    end
  end
end
