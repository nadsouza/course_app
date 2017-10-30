class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.string :name
      t.integer :user_id
      t.text :description

      t.timestamps
    end

    add_index :courses, :id, unique: true
    add_index :courses, :name, unique: true
  end
end
