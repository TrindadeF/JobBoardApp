class Job < ApplicationRecord
  belongs_to :recruiter, class_name: 'User', foreign_key: 'recruiter_id'
  has_many :applications, dependent: :destroy
  validates :title, :requirements, :education, :location, presence: true
end
