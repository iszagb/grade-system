class SendGradeUpdateEmailJob < ApplicationJob
  queue_as :default

  def perform(student, course, grade)
    StudentMailer.grade_updated(student, course, grade).deliver_later
  end
end
