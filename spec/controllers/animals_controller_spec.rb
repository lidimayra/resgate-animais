require 'rails_helper'

RSpec.describe AnimalsController, type: :controller do

  let(:animal) { create(:animal) }
  let(:permitted_params) do
    [:nome, :peso, :especie, :data_registro, :data_saida]
  end

  describe '#index' do
    subject { get :index }
    render_views

    it { is_expected.to render_template :index }
  end

  describe '#show' do
    subject { get :show, id: animal }
    render_views

    it { is_expected.to render_template :show }
  end

  describe '#new' do
    subject { get :new }
    render_views

    it { is_expected.to render_template :new }
  end

  describe '#create' do

    let(:animal_valido) { attributes_for(:animal) }
    let(:animal_invalido) { attributes_for(:animal).except(:data_registro) }
    let(:params) { {animal: animal_valido} }

    it 'filters allowed params' do
      is_expected.to permit(*permitted_params)
      .for(:create, params: params)
    end

    context 'com atributos válidos' do

      subject { post :create, animal: animal_valido }

      it 'salva o animal' do
        expect{ subject }.to change(Animal, :count).by(1)
      end

      it 'exibe mensagem de sucesso' do
        subject
        expect(controller).to set_flash[:notice]
        .to(I18n.t('animals.create.success') % { nome: animal_valido[:nome] } )
      end

      it { is_expected.to redirect_to animals_path }
    end

    context 'com atributos inválidos' do

      subject { post :create, animal: animal_invalido }

      it 'não salva o animal' do
        expect{ subject }.not_to change(Animal, :count)
      end

      it 'exibe mensagem de erro' do
        subject
        expect(controller).to set_flash[:alert]
        .to(I18n.t('animals.create.failure'))
      end

      it { is_expected.to render_template :new }

    end
  end

  describe "#edit" do
    context 'ao renderizar views' do
      render_views

      subject { get :edit, id: animal }
      it { is_expected.to render_template :edit }
    end
  end

  describe '#update' do

    let(:novo_nome) { Faker::Name.name }
    let(:animal_valido) { attributes_for(:animal, nome: novo_nome) }
    let(:animal_invalido) { attributes_for(:animal, data_registro: '') }
    let(:params) { {animal: animal_valido} }

    it 'permite os parâmetros do usuário' do
      is_expected.to permit(*permitted_params).for(:create, params: params)
    end

    context 'com atributos válidos' do

      subject { patch :update, id: animal, animal: animal_valido }

      it 'atualiza os dados do animal' do
        subject
        animal.reload
        expect(animal.nome).to eq novo_nome
      end

      it 'exibe mensagem de sucesso' do
        subject
        expect(controller).to set_flash[:notice]
        .to(I18n.t('animals.update.success') % { nome: novo_nome })
      end

      it { is_expected.to redirect_to animals_path }
    end

    context 'com atributos inválidos' do

      let(:data_registro_original) { animal.data_registro }

      subject { patch :update, id: animal, animal: animal_invalido }

      it 'não atualiza os dados do animal' do
        subject
        animal.reload
        expect(animal.data_registro).to eq data_registro_original
      end

      it 'exibe mensagem de erro' do
        subject
        expect(controller).to set_flash[:alert]
        .to(I18n.t('.animals.update.failure') % { nome: animal.nome })
      end

      it { is_expected.to render_template :edit }
    end
  end

  describe '#destroy' do

    before { delete :destroy, id: animal }

    it 'remove o animal' do
      expect(Animal.find_by(id: animal.id)).to be_nil
    end

    it 'exibe mensagem de sucesso' do
      expect(controller).to set_flash[:notice]
      .to(I18n.t('animals.destroy.success') % { nome: animal.nome } )
    end

    it { is_expected.to redirect_to animals_path }

  end

end
