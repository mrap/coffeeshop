class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_user!(*args)
    current_user.present? || super(*args)
  end

  alias_method :devise_current_user, :current_user
  def current_user
    super || guest_user
  end

  private

    def guest_user
      unless guest_user = GuestUser.where(token: session[:user_token]).first
        guest_user = GuestUser.create
        session[:user_token] = guest_user.token
      end
      return guest_user
    end

end
