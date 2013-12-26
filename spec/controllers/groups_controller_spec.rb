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

  describe 'GET #show' do
    let(:group) { create(:group) }

    it "should be successful" do
      get :show, id: group.id
      response.should be_successful
    end
  end
end
