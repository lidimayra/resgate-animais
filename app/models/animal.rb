class Animal < ActiveRecord::Base

  enum especie: { arara: 1, cachorro: 2, capivara: 3, gato: 4, papagaio: 5 }

  validates :especie, presence: true
  validates :peso, numericality: { greater_than: 0 }, allow_nil: true
  validates :data_registro, presence: true
  validates_date :data_registro
  validates_date :data_saida, after: :data_registro, allow_blank: true

end
