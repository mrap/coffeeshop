require 'spec_helper'

feature "Users message each other on the front page" do
  background { @message = create(:message) }
  scenario "when visiting the home page" do
    visit '/'
    page.should have_content @message.content
  end
end
