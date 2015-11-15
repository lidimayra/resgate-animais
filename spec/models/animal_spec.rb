require 'rails_helper'

RSpec.describe Animal, type: :model do

  context 'ao validar espécie' do
    it { is_expected.to validate_presence_of :especie }
  end

  context 'ao validar a data de registro' do
    it { is_expected.to validate_presence_of :data_registro }
  end

end
