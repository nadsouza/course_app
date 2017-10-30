class Category < ApplicationRecord
  has_and_belongs_to_many :courses

  before_save :case_format

  validates :name,
  presence: true,
  length: {
    minimum: 2,
    maximum: 32
  },
  format: {
    with: /\A[\w\d\s]+\z/,
    message: 'is invalid, no special characters allowed'
  },
  uniqueness: {
    case_sensitive: false
  }

  def case_format
      self.name = self.name.split.map(&:capitalize).join(' ')
  end
end
