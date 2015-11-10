class Users::RegistrationsController < Devise::RegistrationsController
  layout "map"

  def edit
    @user = current_user
  end

  def destroy
    @char = current_user.chars.find(params[:char])

    if @char && current_user.chars.count > 1
      flash[:notice] = "#{@char.name} Deleted"
      @char.destroy
    else
      flash[:alert] = "You cannot delete all your chars"
    end
    redirect_to edit_user_registration_path
  end

  private
  def user_params
    params.require(:user).permit(:username, chars_attributes: [:provider, :uid, :name, :owner, :ccp_id])
  end
end
