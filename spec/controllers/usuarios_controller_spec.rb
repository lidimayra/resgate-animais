require 'rails_helper'

RSpec.describe UsuariosController, type: :controller do

  let(:admin) { create(:usuario, :admin) }
  let(:atendente) { create(:usuario, :atendente) }

  let(:permitted_params) do
    [:nome, :email, :password, :data_registro, :data_desligamento, :perfil]
  end

  before { sign_in admin }

  describe '#index' do

    context 'ao renderizar as views' do

      render_views

      subject { get :index }
      it { is_expected.to render_template :index }
    end
  end

  describe '#show' do

    context 'ao renderizar as views' do

      render_views

      subject { get :show, id: admin }
      it { is_expected.to render_template :show }
    end
  end

  describe '#new' do

    context 'ao renderizar as views' do
      render_views

      subject { get :new }

      it { is_expected.to render_template :new }
    end

  end

  describe '#create' do

    let(:usuario_valido) { attributes_for(:usuario, perfil: 'atendente') }
    let(:usuario_invalido) { attributes_for(:usuario).except(:nome) }
    let(:params) { {usuario: usuario_valido} }


    it 'permite os parâmetros do usuário' do
      is_expected.to permit(*permitted_params)
      .for(:create, params: params)
    end

    context 'com atributos válidos' do

      subject { post :create, usuario: usuario_valido }

      it 'salva o usuário no banco de dados com senha padrão' do
        expect{ subject }.to change(Usuario, :count).by 1
        expect(controller.usuario.password).to eq '12345678'
      end

      it 'exibe mensagem de sucesso' do
        subject
        expect(controller).to set_flash[:notice].to(I18n.t(
          'usuarios.create.success') % { nome: usuario_valido[:nome] })
      end

      it { is_expected.to redirect_to usuarios_path }
    end

    context 'com atributos inválidos' do

      subject { post :create, usuario: usuario_invalido }

      it 'não salva o usuário no banco de dados' do
        expect{ subject }.to_not change(Usuario, :count)
      end

      it 'exibe mensagem de erro' do
        subject
        expect(controller).to set_flash[:alert].to(I18n.t(
          'usuarios.create.failure'))
      end

      it { is_expected.to render_template :new }
    end
  end

  describe '#update' do

    let(:novo_nome) { Faker::Name.name }
    let(:usuario_valido) do
      attributes_for(:usuario, nome: novo_nome, perfil: 'atendente')
    end
    let(:params) { {id: atendente, patch: usuario_valido} }

    context 'quanto aos parâmetros' do

      it 'permite os parâmetros do usuário' do
        is_expected.to permit(*permitted_params).for(:update, params: params)
      end
    end

    context 'com atributos válidos' do

      subject { patch :update, id: atendente, usuario: usuario_valido }

      it 'atualiza os dados do Usuário' do
        subject
        expect(Usuario.find(atendente.id).nome).to eq novo_nome
      end

      it 'exibe mensagem de sucesso' do
        subject
        expect(controller).to set_flash[:notice].to(I18n.t(
          'usuarios.update.success') % { nome: novo_nome })
      end

      it { is_expected.to redirect_to usuarios_path }
    end

    context 'com atributos inválidos' do

      let(:data_registro_original) { admin.data_registro }
      let(:usuario_invalido) { attributes_for(:usuario, data_registro: nil) }

      subject { patch :update, id: atendente, usuario: usuario_invalido }

      it 'não atualiza os dados do usuário' do
        subject
        atendente.reload
        expect(atendente.data_registro).to eq data_registro_original
      end

      it 'exibe mensagem de erro' do
        subject
        expect(controller).to set_flash[:alert].to(I18n.t(
          'usuarios.update.failure') % { nome: admin.nome } )
      end

      it { is_expected.to render_template :edit }
    end
  end

  describe '#destroy' do

    before { delete :destroy, id: atendente }

    it 'remove o usuário' do
      expect(Usuario.find_by(id: atendente.id)).to be_nil
    end

    it 'exibe mensagem de sucesso' do
      expect(controller).to set_flash[:notice].to(I18n.t(
        'usuarios.destroy.success') % { nome: admin.nome } )
    end

    it { is_expected.to redirect_to usuarios_path }

  end
end
