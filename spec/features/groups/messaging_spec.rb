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
      fill_in 'message', with: "My Message!"
      click_on 'Post'
      page.should have_content "My Message!"
    end
  end

  scenario "I can see updates from other users (after reloading)" do
    in_browser(:theirs) do
      fill_in 'message', with: "Hello!"
      click_on 'Post'
    end
    in_browser(:mine) do
      visit group_path(group)
      page.should have_content "Hello!"
    end
  end

  xscenario "I can see updates from other users in realtime" do
    in_browser(:theirs) do
      fill_in 'message', with: "Hello!"
      click_on 'Post'
    end
    in_browser(:mine) do
      page.should have_content "Hello!"
    end
  end

end
