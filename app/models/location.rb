class Location < ApplicationRecord
  has_and_belongs_to_many :courses

  validates :name,
    presence: true,
    length: {
      minimum: 10,
      maximum: 10
    },
    format: {
      with: /\A[\d]{1,3}\.[\d]{1,2}\.[\d]{1,4}\z/,
      message: 'must be in the format of RMIT location names (format 001.01.100)'
    },
    uniqueness: {
      case_sensitive: false
    }
end
