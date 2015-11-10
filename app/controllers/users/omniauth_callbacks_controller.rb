class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :get_user

  def crest
    if user_signed_in?
      @user.chars.create( provider: auth_hash.provider,
                         uid: auth_hash.uid,
                         name: auth_hash.info.name,
                         owner: auth_hash.info.character_owner_hash)
      redirect_to edit_user_registration_path, notice: "Added character auth: #{auth_hash.info.name}"
    else
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Crest") if is_navigational_format?
    end
  end

  private
  def get_user
    if user_signed_in?
      @user = current_user
    else
      @user = User.from_omniauth( request.env["omniauth.auth"] )
    end
  end

  def auth_hash
    request.env["omniauth.auth"]
  end
end
