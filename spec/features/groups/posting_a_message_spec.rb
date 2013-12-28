require 'spec_helper'

feature "A user posting a message in a group" do

  given(:group) { create(:group) }
  given(:user)  { create(:user) }
  background { login_registered_user(user) }

  scenario "when on the group page" do
    visit group_path(group)
    fill_in 'message', with: "my new message"
    click_on 'Post'
    find('.message-group').should have_content "my new message"
    find('.message-group').should have_content user.username
  end

end
