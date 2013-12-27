require 'spec_helper'

feature "A user can join a room" do
  background { @group = create(:group, name: "Programming") }
  scenario "from groups#index" do
    visit groups_path
    click_on @group.name
    current_path.should eq group_path(@group)
  end
end
