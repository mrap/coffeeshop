require 'spec_helper'

feature "A user can create a feature request" do

  background do
    visit '/'
    click_on 'Feature Requests'
  end

  scenario "with a valid feature request" do
    fill_in 'Description', with: "Up/downvote messages"
    click_on I18n.t('new_feature_request_button')
    find('.alert').should have_content I18n.t('flash_success_create_feature_request')
    find('.feature-request-list').should have_content "Up/downvote messages"
  end

  scenario "when a feature request is too short" do
    fill_in 'Description', with: "Too short."
    click_on I18n.t('new_feature_request_button')
    find('.alert').should have_content "too short"
    find('.feature-request-list').should_not have_content "Up/downvote messages"
  end

end
