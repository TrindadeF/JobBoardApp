class Application < ApplicationRecord
  belongs_to :job
  belongs_to :user


  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :resume, presence: true
  validate :unique_application_for_user, on: :create

  def unique_application_for_user
    if job && user && job.applications.where(user_id: user.id).exists?
      errors.add(:base, "Você já aplicou para esta vaga.")
    end
  end
end
