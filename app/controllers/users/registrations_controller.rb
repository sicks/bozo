class Users::RegistrationsController < Devise::RegistrationsController

  def new
    @user = User.new
  end

  def create
    params[:user].merge!(auths_attributes: [(session["devise.google_data"] || session["devise.steam_data"])])
    @user = User.new( user_params )

    if @user.save
      sign_in_and_redirect @user, event: :authentication, notice: "New Account Created"
    else
      render :new
    end
  end

  def edit

  end

  private
  def user_params
    params.require(:user).permit(:username, auths_attributes: [:provider, :uid])
  end
end
