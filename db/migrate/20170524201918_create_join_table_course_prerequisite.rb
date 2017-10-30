class CreateJoinTableCoursePrerequisite < ActiveRecord::Migration[5.0]
  def change
    create_join_table :courses, :prerequisites do |t|
      t.index :course_id
      t.index :prerequisite_id
    end
  end
end
