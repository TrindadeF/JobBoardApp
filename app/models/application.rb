class Application < ApplicationRecord
  belongs_to :job
  validates :name, :email, :resume, presence: true
end
