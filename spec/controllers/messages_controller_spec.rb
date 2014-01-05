require 'spec_helper'

describe MessagesController do

  describe "GET #index" do
    it "should assign all messages" do
      get :index
      assigns(:messages).should eq Message.all
    end
  end

  describe "POST #create" do
    let(:create_message)  { post :create, message: { content: "my message" } }

    context "when user is guest user" do
      let(:guest_user) { create(:guest_user) }
      before { ApplicationController.any_instance.stub(:current_or_guest_user).and_return(guest_user) }
      it "should set message author to the current user" do
        create_message
        message = Message.last
        message.author.should eq guest_user
      end
    end

    context "when user is a registered user" do
      let(:user)            { create(:user) }
      before { ApplicationController.any_instance.stub(:current_or_guest_user).and_return(user) }
      it "should set message author to the current user" do
        create_message
        message = Message.last
        message.author.should eq user
      end
    end
  end

end
