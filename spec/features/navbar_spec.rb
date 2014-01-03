require 'spec_helper'

feature "Navbar" do
  xscenario "when user is registered" do
    user = create(:user)
    sign_in_user(user)
    find('.navbar') do |n|
      n.should have_content user.username
      n.should have_content 'Sign Out'
    end
  end

  xscenario "when user is not registered" do
    visit '/'
    guest_user = User.last
    find('.navbar').should have_content guest_user.username
    find('.navbar').should_not have_content 'Sign Out'
    find('.navbar').should have_content 'Sign In'
  end

end
