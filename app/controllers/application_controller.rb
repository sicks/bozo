class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login

  def slugroute
    render text: "page", layout: "map"
  end

  def new_session_path(scope)
    new_user_session_path
  end

  def require_login
    redirect_to new_user_session_path unless user_signed_in?
  end

  def igb_data
    if request.headers.env["HTTP_EVE_TRUSTED"] == "Yes"
      @igb ||= {
        trusted: "Yes",
        system: { name: request.headers.env["HTTP_EVE_SOLARSYSTEMNAME"], ccp_id: request.headers.env["HTTP_EVE_SOLARSYSTEMID"]},
        character: { name: request.headers.env["HTTP_EVE_CHARNAME"], ccp_id: request.headers.env["HTTP_EVE_CHARID"] },
        ship: request.headers.env["HTTP_EVE_SHIPTYPEID"]
      }
    else
      @igb = false
    end
  end
end
