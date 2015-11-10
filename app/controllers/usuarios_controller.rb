class UsuariosController < ApplicationController

  USUARIO_PARAMS = [:nome, :email, :password, :data_registro,
                    :data_desligamento, :perfil]

  expose(:usuarios)
  expose(:usuario, attributes: :usuario_params)

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
      redirect_to usuarios_path
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

end
