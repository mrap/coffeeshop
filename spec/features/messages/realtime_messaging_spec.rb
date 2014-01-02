require 'spec_helper'

feature "Realtime messages between users", js: true do
  given(:group)     { create(:group) }
  given(:me) { create(:user) }
  given(:other_user) { create(:user) }

  context "when they and I are both in the group" do
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

    scenario "I can see updates from other users in realtime" do
      in_browser(:theirs) do
        fill_in 'message', with: "Hello!"
        click_on 'Post'
      end
      in_browser(:mine) do
        page.should have_content "Hello!"
      end
    end
  end

end

