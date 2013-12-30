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
    find('.group-header').should_not have_content 'You and'
  end

  context "when 1 other member" do
    given(:group) { create(:group_with_members, members_count: 1) }
    scenario "pages shows members count" do
      visit_page
      find('.group-header').should have_content "You and 1 other person"
    end
  end

  context "when 2 or more other members" do
    given(:group) { create(:group_with_members, members_count: 2) }
    scenario "pages shows members count" do
      visit_page
      find('.group-header').should have_content "You and 2 other people"
    end
  end

  scenario "when the group has at least one message" do
    message = create(:message, group: group)
    visit group_path(group.id)
    page.should have_content message.content
    page.should have_content message.author.username
  end

  scenario "when the group has more than one message" do
    message = create(:message, group: group)
    message2 = create(:message, group: group)
    visit group_path(group.id)
    message2.content.should appear_before(message.content)
  end

end
