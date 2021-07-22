class MessagesController < ApplicationController
  before_action :authenticate_user
  before_action :set_channel

  def chat
    @chat
    @message = Message.new
  end

  def send_message
    @message = @chat.messages.build(message_params)
    @message.save
    ChatChannel.broadcast_to @chat, message: @message
  end

  private

  def set_pipLine
    pipename = [current_user.id, params[:id].to_i].sort
    return "DM:#{pipename.join(":")}"
  end

  def set_channel
    @chat = Chat.find_by(title: set_pipLine)
    p @chat
    if !@chat
      @chat = current_user.chats.build(title: set_pipLine)
      @chat.save
    end
  end

  def message_params
    params.require(:message).permit(:body)
  end
end
