class RegistrationsController < Devise::RegistrationsController

  private

  def account_update_params
    params.require(:usuario).permit(
      :nome,
      :email,
      :password,
      :password_confirmation,
      :current_password)
  end

end
