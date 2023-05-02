class Project < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: {minimum: 2}
  validates :description, presence: true
  validates :user_id, presence: true
end
