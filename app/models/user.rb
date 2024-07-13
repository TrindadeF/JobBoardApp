class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validates :user_type, presence: true
         has_many :applications
         has_many :applied_jobs, through: :applications, source: :job

         def name
        
         end
end
