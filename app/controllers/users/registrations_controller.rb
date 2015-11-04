class Users::RegistrationsController < Devise::RegistrationsController

  def new
    @user = User.new
  end

  def create
    auth_hash = (session["devise.google_data"] || session["devise.steam_data"])
    params[:user].merge!(auths_attributes: [ auth_hash ])

    @user = User.new( user_params )

    if @user.save
      sign_in @user, event: :authentication
      redirect_to root_path, notice: "Registration Successful"
    else
      render :new
    end
  end

  def edit
    @user = current_user
  end

  private
  def user_params
    params.require(:user).permit(:username, auths_attributes: [:provider, :uid])
  end
end
