class GroupsController < ApplicationController
  def index
    @groups = Group.most_members
  end
end
