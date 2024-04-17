class Grade < ApplicationRecord
  belongs_to :student_course

  enum quarter: { Quarter1: 0, Quarter2: 1, Quarter3: 2, Quarter4: 3 }

  validates :score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  validates :student_course_id, uniqueness: { scope: :quarter }
  after_commit :send_grade_update_email, on: [:create, :update]

  def status
    case self.score
    when (0..5)
      "Failed"
    when (6..10)
      "Passed"
    end
  end

  private

  def send_grade_update_email
    SendGradeUpdateEmailJob.perform_later(student_course.student, student_course.course, self)
  end
end
