class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :get_user
  # We must disable CSRF check when Steam issues the callback request.
  skip_before_action :verify_authenticity_token, only: [:steam]

  def steam
    if @user
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Steam") if is_navigational_format?
    else
      session["devise.steam_data"] = { provider: auth_hash.provider, uid: auth_hash.uid }
      redirect_to new_user_registration_path
    end
  end

  def google_oauth2
    if @user
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
    else
      session["devise.google_data"] = { provider: auth_hash.provider, uid: auth_hash.uid }
      redirect_to new_user_registration_path
    end
  end

  private
  def get_user
    if user_signed_in?
      additional_auth = current_user.auths.build( provider: auth_hash.provider, uid: auth_hash.uid )
      if additional_auth.save
        redirect_to edit_user_registration_path, notice: "New #{additional_auth.name.humanize} Auth successfully added"
      end
    else
      @user = User.from_omniauth( request.env["omniauth.auth"] )
    end
  end

  def auth_hash
    request.env["omniauth.auth"]
  end
end
