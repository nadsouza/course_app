class CreateJoinTableCourseLocation < ActiveRecord::Migration[5.0]
  def change
    create_join_table :courses, :locations do |t|
      t.index :course_id
      t.index :location_id
    end
  end
end
