class User < ApplicationRecord

  has_paper_trail
  has_one_attached :photo
  has_one_attached :curriculo
  has_many :applications
  has_many :applications
  has_many :applied_jobs, through: :applications, source: :job
  has_many :jobs, foreign_key: :recruiter_id
  

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable

  validates :user_type, :name, :telefone, :curriculo, :graduacao, :numero_matricula, :habilidades_tecnicas, :periodo_curso, presence: true, if: :academic?
  validates :nome_empresa, :razao_social, presence: true, if: :recruiter?
  validates :cnpj, presence: true, if: :recruiter?
  validate  :valid_cnpj, if: :recruiter?


  def valid_cnpj
    errors.add(:cnpj, 'is not valid') unless CNPJ.valid?(cnpj)
  end

  def academic?
    user_type == 'academic'
  end

  def recruiter?
    user_type == 'recruiter'
  end
  
  def timeout_in
    30.minutes
  end

end
