class Users::SessionsController < Devise::SessionsController
  skip_before_action :require_login, only: [:new, :create]
  layout "bare"

  def new

  end

end
