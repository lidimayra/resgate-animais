require 'rails_helper'

RSpec.describe Usuario, type: :model do

  subject { build(:usuario) }

  describe 'validações' do

    context 'ao validar nome' do
      it { is_expected.to validate_presence_of :nome }
    end

    context 'ao validar perfil' do
      it { is_expected.to validate_presence_of :perfil }
    end

    context 'ao validar e-mail' do
      it { is_expected.to validate_presence_of :email }
      it { is_expected.to validate_uniqueness_of :email }
    end

    context 'ao validar data de registro' do
      it { is_expected.to validate_presence_of :data_registro }
    end

    context 'ao validar data de desligamento' do

      it 'deve ser posterior à data de registro' do
        usuario = build(:usuario, :datas_invalidas)
        expect(usuario).to_not be_valid
      end
    end
  end

end
