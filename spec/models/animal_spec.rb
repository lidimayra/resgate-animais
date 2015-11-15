require 'rails_helper'

RSpec.describe Animal, type: :model do

  context 'ao validar espécie' do
    it { is_expected.to validate_presence_of :especie }
  end

  context 'ao validar a data de registro' do
    it { is_expected.to validate_presence_of :data_registro }
  end

  context 'ao validar o peso' do
    it { is_expected.to validate_numericality_of(:peso).is_greater_than(0) }
  end

  context 'ao validar data de desligamento' do

    it 'deve ser posterior à data de registro' do
      animal = build(:animal, :datas_invalidas)
      expect(animal).to_not be_valid
    end
  end

end
