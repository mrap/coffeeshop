require 'spec_helper'

# Stub ApplicationController
# get :index to test
class TestController < ApplicationController
  def index
    render nothing: true
  end

  test_routes = Proc.new do
      get '/index' => 'test#index'
  end
  Rails.application.routes.eval_block(test_routes)
end

describe TestController do
  let(:current_user) { controller.send(:current_user) }

  context "when no token is present in session" do
    it "should set current user to a new unregistered user" do
      current_user.should be_instance_of GuestUser
    end
  end

  context "when valid guest_user token in session" do
    let(:guest_user) { create(:guest_user) }
    it "should set current user to the correct guest_user" do
      session[:user_token] = guest_user.token
      current_user.should eq guest_user
    end
  end

end
