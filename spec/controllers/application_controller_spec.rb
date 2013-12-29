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

  describe "guest user" do
    let(:current_or_guest_user) { controller.send(:current_or_guest_user) }

    context "when no token is present in session" do
      it "should correctly set the guest user" do
        current_or_guest_user.should be_instance_of User
      end
    end

    context "when valid guest_user_id in session" do
      let(:guest_user) { create(:user) }
      it "should set guest user" do
        session[:guest_user_id] = guest_user.id
        current_or_guest_user.should eq guest_user
      end
    end
  end
end
