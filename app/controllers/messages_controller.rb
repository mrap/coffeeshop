class MessagesController < ApplicationController
  before_action :set_group

  def index
    redirect_to @group
  end

  def create
    @message = @group.messages.new(params[:message])
    @message.author = current_or_guest_user
    @message.save!
    respond_to do |format|
      format.html { redirect_to @group }
      format.js
    end
  end

  private

    def set_group
      @group = Group.find(params[:group_id])
    end
end
