class Animal < ActiveRecord::Base

  enum especie: { arara: 1, cachorro: 2, capivara: 3, gato: 4, papagaio: 5 }

  validates :especie, presence: true
  validates :data_registro, presence: true

end
