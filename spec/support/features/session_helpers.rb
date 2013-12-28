module Features
  module SessionHelpers
    def login_registered_user(user = nil)
      user ||= create(:user)
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Sign in'
    end
  end
end
