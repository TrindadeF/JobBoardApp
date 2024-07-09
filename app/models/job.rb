class Job < ApplicationRecord
    validates :title, :requirements, :education, presence: true
  end
  