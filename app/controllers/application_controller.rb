class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_or_guest_user

  def current_or_guest_user
    if current_user
      if session[:guest_user_id]
        #TODO: Convert guest_user -> user
        guest_user.destroy
        session[:guest_user_id] = nil
      end
      current_user
    else
      guest_user
    end
  end

  def guest_user
    @guest_user ||= User.where(id: session[:guest_user_id]).first || new_guest_user
  end


  private

    def new_guest_user
      user = GuestUser.create!
      session[:guest_user_id] = user.id
      user
    end

end
