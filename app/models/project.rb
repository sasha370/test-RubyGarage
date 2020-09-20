class Project < ApplicationRecord

  validates :name, presence: true, length: {minimum: 3, maximum: 100}

  belongs_to :user
  has_many :tasks
end
