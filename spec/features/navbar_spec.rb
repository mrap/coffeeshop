require 'spec_helper'

feature "Navbar" do
  scenario "when user is registered" do
    user = create(:user)
    login_registered_user(user)
    find('.navbar') do |n|
      n.should have_content user.username
      n.should have_button 'Sign Out'
    end
  end

  scenario "when user is not registered" do
    visit '/'
    user = GuestUser.last
    find('.navbar') do |n|
      n.should have_content user.username
      n.should_not have_button 'Sign Ou'
    end
  end
end
