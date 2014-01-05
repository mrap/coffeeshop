require 'spec_helper'

feature "User views the homepage" do
  given(:visit_home) { visit '/' }

  scenario "shows the tagline" do
    visit_home
    page.should have_content I18n.t 'tag_line'
  end

  scenario "orders messages from newest to oldest" do
    message = create(:message)
    message2 = create(:message)
    visit_home
    message2.content.should appear_before(message.content)
  end

  # feature "shows pluralized users count" do
  #   scenario "when less than 2 members" do
  #     visit_home
  #     page.should_not have_content 'You and'
  #   end

  #   context "when 1 other member" do
  #     scenario "pages shows members count" do
  #       visit_home
  #       page.should have_content "You and 1 other person"
  #     end
  #   end

  #   context "when 2 or more other members" do
  #     scenario "pages shows members count" do
  #       visit_home
  #       page.should have_content "You and 2 other people"
  #     end
  #   end
  # end

end
