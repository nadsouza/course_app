class Prerequisite < ApplicationRecord
  has_and_belongs_to_many :courses, dependent: :destroy

  # Get the prerequisite name
  # Not to confuse with the course_id name
  def name
    Course.find(self.id).name
  end
end
