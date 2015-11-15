class Usuario < ActiveRecord::Base
  devise :database_authenticatable, :registerable,# :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  enum perfil: { administrador: 1, atendente: 2 }

  validates :nome, presence: true, format: { with: /[\w]+([\s]+[\w]+){1}+/ }
  validates :perfil, presence: true
  validates :data_registro, presence: true

  validates_date :data_desligamento, after: :data_registro, allow_blank: true

end
