require 'spec_helper'

feature "User views the homepage" do
  scenario "shows the tagline" do
    visit '/'
    page.should have_content I18n.t 'tag_line'
  end
end
