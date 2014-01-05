class MessagesController < ApplicationController

  def index
    @messages = Message.all
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
