class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_user!(*args)
    current_user.present? || super(*args)
  end

  alias_method :devise_current_user, :current_user
  def current_user
    super || unregistered_user
  end

  private

    def unregistered_user
      unless unregistered_user = UnregisteredUser.where(token: session[:user_token]).first
        unregistered_user = UnregisteredUser.create
        session[:user_token] = unregistered_user.token
      end
      return unregistered_user
    end

end
