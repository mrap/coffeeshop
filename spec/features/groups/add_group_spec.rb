require 'spec_helper'

feature "A User can add a group" do
  scenario "when user is viewing group's index page" do
    visit groups_path
    fill_in 'Group Name', with: "Programming"
    click_on 'Create Group'
    group = Group.where(name: "Programming").first
    current_path.should eq group_path(group.id)
  end
end
