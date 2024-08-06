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

  validates :user_type, presence: true
  validates :name, presence: true
  validates :telefone, presence: true
  validates :curriculo, presence: true
  validates :graduacao, presence: true
  validates :numero_matricula, presence: true
  validates :habilidades_tecnicas, presence: true
  validates :periodo_curso, presence: true
  validates :nome_empresa, presence: true
  validates :razao_social, presence: true
  
  validates :cpf, presence: true, if: :academic?
  validate  :valid_cpf, if: :academic?

  def valid_cpf
    errors.add(:cpf, 'is not valid') unless CPF.valid?(cpf)
  end

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
