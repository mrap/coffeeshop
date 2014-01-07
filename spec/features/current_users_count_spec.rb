require 'spec_helper'

feature "Chat displays number of current users in realtime" do
  given(:visit_chat) { visit '/' }
  given(:chat_count) { find('.chat-count') }

  context "when I am the only current user" do
    background do
      in_browser(:me) { visit_chat }
    end
    scenario "page reads 'you are'" do
      in_browser(:me) { chat_count.should have_content "You are" }
    end

    context "when another user enters" do
      background do
        in_browser(:user2) { visit_chat }
      end
      scenario "both pages update to 'You and 1 other person'" do
        in_browser(:me)    { chat_count.should have_content "You and 1 other person" }
        in_browser(:user2) { chat_count.should have_content "You and 1 other person" }
      end

      context "when a third user enters" do
        background do
          in_browser(:user3) { visit_chat }
        end
        scenario "all pages update to 'You and 2 other people'" do
          in_browser(:me)       { chat_count.should have_content "You and 2 other people" }
          in_browser(:user2)    { chat_count.should have_content "You and 2 other people" }
          in_browser(:user3)    { chat_count.should have_content "You and 2 other people" }
        end

        context "when the third user leaves" do
          background do
            in_browser(:user3) do
              page.execute_script "window.close();"
            end
          end
          scenario "all pages update back to 'You and 1 other person'" do
            in_browser(:me)       { chat_count.should have_content "You and 1 other person" }
            in_browser(:user2)    { chat_count.should have_content "You and 1 other person" }
          end
        end
      end
    end
  end
end
