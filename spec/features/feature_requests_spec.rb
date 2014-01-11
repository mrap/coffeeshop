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

feature "A user can upvote or downvote a feature request once" do

  background do
    create(:feature_request)
  end

  scenario "upvoting a feature request" do
    visit feature_requests_path
    click_on 'upvote'
    find('.votes-total').should have_content '1'
  end

  scenario "downvoting a feature request" do
    visit feature_requests_path
    click_on 'downvote'
    find('.votes-total').should have_content '-1'
  end

  feature "reversing vote" do
    background do
      visit feature_requests_path
      click_on 'upvote'
    end
    scenario "changing user's upvote to downvote" do
      click_on 'downvote'
      find('.votes-total').should have_content '-1'
    end
  end

end

feature "Feature request can be marked as 'completed'" do
  # Currently, feature requests are set as 'completed'
  # via the production server's rails console
  background do
    create(:feature_request, completed: true)
  end

  scenario "completed feature requests display as 'completed'" do
    visit feature_requests_path
    page.should have_content "Completed"
  end

end
