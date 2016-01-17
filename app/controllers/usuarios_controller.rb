class UsuariosController < ApplicationController
  before_action :authenticate_usuario!
  before_filter :check_admin!

  USUARIO_PARAMS = [:nome, :email, :password, :data_registro,
                    :data_desligamento, :perfil]

  expose(:usuarios)
  expose(:usuario, attributes: :usuario_params)

  def index
    if params[:perfil]
      self.usuarios = Usuario.where(perfil: params[:perfil]) unless params[:perfil] == ""
    end
  end

  def create
    usuario.password = t('.default_password')
    if usuario.save
      flash[:notice] = t('.success', nome: usuario.nome)
      redirect_to usuarios_path
    else
      flash[:alert] = t('.failure')
      render :new
    end
  end

  def update
    if usuario.save
      flash[:notice] = t('.success', nome: usuario.nome)
      redirect_to usuarios_path
    else
      flash[:alert] = t('.failure', nome: Usuario.find(usuario.id).nome)
      render :edit
    end
  end

  def destroy
    if usuario.destroy
      flash[:notice] = t('.success', nome: usuario.nome)
    else
      flash[:alert] = t('.failure', nome: usuario.nome)
    end
    redirect_to usuarios_path
  end

  private

  def usuario_params
    params.require(:usuario).permit(USUARIO_PARAMS)
  end

  def check_admin!
    unless current_usuario.administrador?
      flash[:alert] = t('.permission_denied')
      redirect_to root_path
    end
  end
end
