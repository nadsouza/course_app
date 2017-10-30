class Course < ApplicationRecord
  # Categories
  has_and_belongs_to_many :categories, dependent: :destroy

  # Locations
  has_and_belongs_to_many :locations, dependent: :destroy

  # Prerequisites
  has_and_belongs_to_many :prerequisites, dependent: :destroy

  # Upvotes
  has_many :upvotes, dependent: :destroy

  # Downvotes
  has_many :downvotes, dependent: :destroy

  belongs_to :user

  mount_uploader :image, CourseUploader

  validates :categories,
    presence: true
  validates :locations,
    presence: true
  validates :name,
    presence: true,
    length: {
      minimum: 2,
      maximum: 32
    },
    format: {
      with: /\A[\w\s\d]+\z/i,
      message: 'is invalid, must only contain alpha-numeric characters.'
    },
    uniqueness: {
      case_sensitive: false
    }
  validates :description,
    presence: true,
    length: {
      minimum: 30,
      maximum: 1024
    }
end
