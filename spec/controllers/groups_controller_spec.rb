require 'spec_helper'

describe GroupsController do
  describe 'GET #index' do
    it "should be successful" do
      get :index
      response.should be_successful
    end

    it "loads all groups into @groups ordered by members" do
      get :index
      assigns(:groups).should eq Group.most_members
    end
  end
end
