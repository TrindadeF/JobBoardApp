class Application < ApplicationRecord

  STATUSES = ['Pending', 'Reviewed', 'Accepted', 'Rejected']
  
  belongs_to :job
  belongs_to :user
  
  validates :name, :email, :resume, presence: true
  validates :user_id, uniqueness: { scope: :job_id, message: "you have already applied for this job" }

  after_initialize :set_default_status, if: :new_record?
  
  def set_default_status
    self.status ||= 'Pending'
  end
end
