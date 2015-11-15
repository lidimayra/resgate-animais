class AnimalsController < ApplicationController
  before_action :authenticate_usuario!

  ANIMAL_PARAMS = [:nome, :peso, :especie, :data_registro, :data_saida]

  expose(:animals)
  expose(:animal, attributes: :animal_params)

  def create
    if animal.save
      flash[:notice] = t('.success', nome: animal.nome)
      redirect_to animals_path
    else
      flash[:alert] = t('.failure')
      render :new
    end
  end

  def update
    if animal.save
      flash[:notice] = t('.success', nome: animal.nome)
      redirect_to animals_path
    else
      flash[:alert] = t('.failure', nome: animal.nome)
      render :edit
    end
  end

  def destroy
    if animal.destroy
      flash[:notice] = t('.success', nome: animal.nome)
    end
    redirect_to animals_path
  end

  private

  def animal_params
    params.require(:animal).permit(ANIMAL_PARAMS)
  end

end
