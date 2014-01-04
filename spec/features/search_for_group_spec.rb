require 'spec_helper'

feature "User can search for a group" do

  background do
    @programming_group = create(:group, name: "Programming")
    @writing_group = create(:group, name: "Writing")
  end

  scenario "when searching a part of/full the group's name" do
    visit '/'
    fill_in 'I am...', with: "pro"
    click_on 'Find a group'
    page.should have_content "We found some groups that match pro"
    click_on @programming_group.name
    page.should_not have_content @writing_group.name
    current_path.should eq group_path(@programming_group)
  end

  scenario "when the search doesn't return any group" do
    visit '/'
    fill_in 'I am...', with: "freelancing"
    click_on 'Find a group'
    page.should have_content "We couldn't find any groups that are freelancing"
    click_on "Let's start the freelancing group"
    current_path.should eq group_path(Group.where(name: "freelancing").first)
  end
end
