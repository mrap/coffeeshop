require 'spec_helper'

feature "Realtime messages between users", js: true do
  given(:group)      { create(:group) }
  given(:me)         { create(:user) }
  given(:other_user) { create(:user) }

  context "when they and I are both in the group" do
    background do
      in_browser(:mine) do
        visit group_path(group)
      end
      in_browser(:theirs) do
        visit group_path(group)
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

    context "when I go to another group page" do
      background do
        group2 = create(:group)
        in_browser(:mine) do
          click_on 'Doing Now'
          click_on group2.name
        end
      end

      scenario "I should not see their new messages" do
        in_browser(:theirs) do
          fill_in I18n.t('new_message_prompt'), with: "Hello again!"
          click_on I18n.t 'new_message_button'
        end
        in_browser(:mine) do
          find('.message-list').should_not have_content "Hello again!"
        end
      end

    end
  end
end

