require 'spec_helper'

feature "Realtime messages between users", js: true do
  given(:me)         { create(:user) }
  given(:other_user) { create(:user) }

  background do
    in_browser(:mine) do
      visit '/'
    end
    in_browser(:theirs) do
      visit '/'
    end
  end

  scenario "I can see updates from other users in realtime" do
    in_browser(:theirs) do
      fill_in I18n.t('new_message_prompt'), with: "Hello!"
      click_on I18n.t 'new_message_button'
    end
    in_browser(:mine) do
      find('.message-list').should have_content "Hello!"
    end
  end

  scenario "when my text box is not empty and another user posts a message" do
    in_browser(:mine) do
      fill_in 'Content', with: "Incomplete message"
    end
    in_browser(:theirs) do
      fill_in I18n.t('new_message_prompt'), with: "Hello!"
      click_on I18n.t 'new_message_button'
    end
    in_browser(:mine) do
      find_field('Content').value.should eq "Incomplete message"
    end
  end

end

