require 'spec_helper'

feature "Viewing a list of all groups with member counts" do
  background do
    @programming = create(:group, name: "programming")
    @writing     = create(:group, name: "writing")
    create_list(:user, 2, group: @programming)
    create_list(:user, 1, group: @writing)
  end

  scenario "when a user visits groups index" do
    visit groups_path
    page.should have_content @programming.name
    page.should have_content @writing.name
    page.should have_content @programming.members.count
    page.should have_content @writing.members.count
  end
end
