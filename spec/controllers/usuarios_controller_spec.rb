require 'rails_helper'

RSpec.describe UsuariosController, type: :controller do

  let(:usuario) { create(:usuario) }

  let(:permitted_params) do
    [:nome, :email, :senha, :data_registro, :data_desligamento, :perfil]
  end

  describe '#index' do

    context 'ao renderizar as views' do

      render_views

      subject { get :index }
      it { is_expected.to render_template :index }
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

    let(:usuario_valido) { attributes_for(:usuario) }
    let(:usuario_invalido) { attributes_for(:usuario).except(:nome) }
    let(:params) { {usuario: usuario_valido} }

    context 'quanto aos parâmetros' do
      it 'permite os parâmetros do usuário' do
        is_expected.to permit(*permitted_params).for(:create, params: params)
      end
    end

    context 'com atributos válidos' do

      subject { post :create, usuario: usuario_valido }

      it 'salva o usuário no banco de dados' do
        expect{ subject }.to change(Usuario, :count).by 1
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
    let(:usuario_valido) { attributes_for(:usuario, nome: novo_nome) }
    let(:params) { {id: usuario, patch: usuario_valido} }

    context 'quanto aos parâmetros' do

      it 'permite os parâmetros do usuário' do
        is_expected.to permit(*permitted_params).for(:update, params: params)
      end
    end

    context 'com atributos válidos' do

      subject { patch :update, id: usuario, usuario: usuario_valido }

      it 'atualiza os dados do Usuário' do
        subject
        expect(Usuario.find(usuario.id).nome).to eq novo_nome
      end

      it 'exibe mensagem de sucesso' do
        subject
        expect(controller).to set_flash[:notice].to(I18n.t(
          'usuarios.update.success') % { nome: novo_nome })
      end

      it { is_expected.to redirect_to usuarios_path }
    end

    context 'com atributos inválidos' do

      let(:data_registro) { usuario.data_registro }
      let(:usuario_invalido) { attributes_for(:usuario, nome: nil) }

      subject { patch :update, id: usuario, usuario: usuario_invalido }

      it 'não atualiza os dados do usuário' do
        subject
        expect(Usuario.find(usuario.id).data_registro).to eq data_registro
      end

      it 'exibe mensagem de erro' do
        subject
        expect(controller).to set_flash[:alert].to(I18n.t(
          'usuarios.update.failure') % { nome: usuario.nome } )
      end

      it { is_expected.to redirect_to usuarios_path }
    end
  end

  describe '#destroy' do

    before { delete :destroy, id: usuario }

    it 'remove o usuário' do
      expect(Usuario.find_by(id: usuario.id)).to be_nil
    end

    it 'exibe mensagem de sucesso' do
      expect(controller).to set_flash[:notice].to(I18n.t(
        'usuarios.destroy.success') % { nome: usuario.nome } )
    end

    it { is_expected.to redirect_to usuarios_path }

  end
end
