class Job < ApplicationRecord
    validates :title, :requirements, :education, presence: true
    has_many :applications
    has_many :applicants, through: :applications, source: :user
  end
  