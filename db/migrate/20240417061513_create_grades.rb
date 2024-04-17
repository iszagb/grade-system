class CreateGrades < ActiveRecord::Migration[7.1]
  def change
    create_table :grades do |t|
      t.integer :student_course_id, index: true
      t.integer :score
      t.integer :quarter

      t.timestamps
    end

    add_index :grades, [:student_course_id, :quarter], unique: true
  end
end
