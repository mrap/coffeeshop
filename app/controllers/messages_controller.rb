class MessagesController < ApplicationController

  def index
    @messages = Message.all.limit(10)
    # limit is a temporary fix to the lack of pagination.
  end


  def create
    @message = Message.new(params[:message])
    @message.author = current_or_guest_user
    @message.save!
    respond_to do |format|
      format.html { redirect_to action: "index" }
      format.js
    end
  end

end
