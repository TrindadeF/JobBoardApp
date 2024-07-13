class Application < ApplicationRecord
  belongs_to :job
  belongs_to :user
  validates :name, :email, :resume, presence: true
end
