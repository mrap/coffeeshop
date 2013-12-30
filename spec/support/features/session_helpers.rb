module Features
  module SessionHelpers

    # Signs in user through the UI
    def sign_in_user(user = nil)
      user ||= create(:user)
      visit new_user_session_path
      within('form') do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_on 'Sign in'
      end
    end

    # Named Sessions (useful for multiple sessions)
    def in_browser(name)
      Capybara.session_name = name
      yield
    end

  end
end
