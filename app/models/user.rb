class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validates :user_type, presence: true, inclusion: { in: %w[academic recruiter] }
end
