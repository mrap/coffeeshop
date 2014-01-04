require 'spec_helper'

feature "User can search for a group" do

  background do
    @programming_group = create(:group, name: "Programming")
    @writing_group = create(:group, name: "Writing")
  end

  scenario "when searching for a group using it's full name" do
    visit '/'
    fill_in 'I am...', with: @programming_group.name
    click_on 'Find a group'
    click_on @programming_group.name
    page.should_not have_content @writing_group.name
    current_path.should eq group_path(@programming_group)
  end

  scenario "when searching a part of the group's name" do
    visit '/'
    fill_in 'I am...', with: "pro"
    click_on 'Find a group'
    click_on @programming_group.name
    page.should_not have_content @writing_group.name
    current_path.should eq group_path(@programming_group)
  end
end
