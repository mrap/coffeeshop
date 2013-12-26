require 'spec_helper'

feature "Viewing a group page" do
  given(:group) { create(:group) }
  given(:visit_page) { visit group_path(group.id) }

  scenario "basic load" do
    visit_page
    page.should have_content group.name
  end

  scenario "when less than 2 members" do
    visit_page
    page.should_not have_content group.members_count
  end

  context "when 2 or more members" do
    given(:group) { create(:group_with_members, members_count: 2) }
    scenario "pages shows members count" do
      visit_page
      page.should have_content group.members_count
    end
  end

  scenario "when the group has at least one message" do
    message = create(:message, group: group)
    visit group_path(group.id)
    page.should have_content message.content
    page.should have_content message.author.username
  end

end
