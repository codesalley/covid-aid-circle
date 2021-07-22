class MessagesController < ApplicationController
  before_action :authenticate_user
  before_action :set_channel

  def chat
    @chats
    @message = Message.new
  end

  def send_message
  end

  private

  def set_pipLine
    pipename = [current_user.id, params[:id].to_i].sort
    return "DM:#{pipename.join(":")}"
  end

  def set_channel
    @chats = Chat.find_by(title: set_pipLine)
    if !@chats
      @chats = current_user.chats.build(title: set_pipLine)
      @chats.save
    end
  end

  def message_params
  end
end
