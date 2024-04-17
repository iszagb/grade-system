class StudentMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def grade_updated(student, course, grade)
    @student = student
    @course = course
    @grade = grade
    mail(to: @student.user.email, subject: 'Grade Updated')
  end
end
