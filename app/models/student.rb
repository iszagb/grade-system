class Student < ApplicationRecord
  belongs_to :user
  has_many :student_courses
  has_many :courses, through: :student_courses

  def self.search(search_param)
    search_param ? where("first_name LIKE ?", "%#{search_param}%") : none
  end

  def full_name
    first_name + ' ' + last_name
  end
end
