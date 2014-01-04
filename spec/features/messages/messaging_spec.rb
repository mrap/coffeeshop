require 'spec_helper'

feature "Messaging in a group" do
  given(:group)     { create(:group) }
  given(:me) { create(:user) }
  given(:other_user) { create(:user) }

  background do
    in_browser(:mine) do
      sign_in_user(me)
      visit group_path(group)
    end
    in_browser(:theirs) do
      sign_in_user(other_user)
      visit group_path(group)
    end
  end

  scenario "I can see my own updates" do
    in_browser(:mine) do
      fill_in I18n.t('new_message_prompt'), with: "My Message!"
      click_on I18n.t 'new_message_button'
      page.should have_content "My Message!"
    end
  end

  scenario "I can see updates from other users (after reloading)" do
    in_browser(:theirs) do
      fill_in I18n.t('new_message_prompt'), with: "Hello!"
      click_on I18n.t 'new_message_button'
    end
    in_browser(:mine) do
      visit group_path(group)
      page.should have_content "Hello!"
    end
  end

end
