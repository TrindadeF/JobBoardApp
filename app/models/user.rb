class User < ApplicationRecord

  has_paper_trail
  has_one_attached :photo
  has_many :applications
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :user_type, presence: true
  validates :name, presence: true
  validates :telefone, presence: true

  has_many :applications
  has_many :applied_jobs, through: :applications, source: :job

  def name
    
  end
end
