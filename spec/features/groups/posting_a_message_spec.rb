require 'spec_helper'

feature "A user posting a message in a group" do

  given(:group) { create(:group) }
  given(:user)  { create(:user) }
  background { sign_in_user(user) }

  scenario "when on the group page" do
    visit group_path(group)
    fill_in 'message', with: "my new message"
    click_on 'Post'
    within('.message-list') do
      find('.message-item').should have_content "my new message"
      find('.message-item').should have_content user.username
    end
  end

end
