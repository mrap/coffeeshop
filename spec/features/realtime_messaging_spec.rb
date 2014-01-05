require 'spec_helper'

feature "Realtime messages between users", js: true do
  given(:me)         { create(:user) }
  given(:other_user) { create(:user) }

  context "when I visit the home page" do
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
  end
end

