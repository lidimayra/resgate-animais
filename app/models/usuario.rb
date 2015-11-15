class Usuario < ActiveRecord::Base
  devise :database_authenticatable, :registerable,# :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  enum perfil: { administrador: 1, atendente: 2 }

  validates :nome, presence: true
  validates :perfil, presence: true
  validates :data_registro, presence: true

  validates_date :data_desligamento, after: :data_registro, allow_nil: true

end
