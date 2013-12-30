class GroupsController < ApplicationController

  before_action :set_group, only: [:show, :post_message]

  def index
    @groups = Group.most_members
  end

  def show
    @group.add_member(current_or_guest_user)
  end

  def create
    if group = Group.create!(params[:group])
      redirect_to group
    end
  end

  def post_message
    message = Message.new(params[:message])
    message.group = @group
    message.author = current_or_guest_user
    if message.save!
      redirect_to @group
    end
  end

  private

    def set_group
      @group = Group.find(params[:id])
    end

end
