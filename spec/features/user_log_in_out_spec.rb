require 'spec_helper'

feature "Existing user can log in" do

  background { @user = create(:user) }

  scenario "signing in with correct credentials" do
    sign_in_user(@user)
    page.should have_content "Signed in successfully"
  end
end

feature "Existing user can log out" do

  background do
    @user = create(:user)
    sign_in_user(@user)
  end

  scenario "signing out" do
    click_on 'Sign out'
    page.should have_content "Signed out successfully"
  end
end
