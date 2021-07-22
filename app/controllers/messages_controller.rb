class MessagesController < ApplicationController
  before_action :authenticate_user
  before_action :set_channel

  def chat
    @chat
    @receiver = User.find_by(id: params[:id])
    @message = Message.new
  end

  def send_message
    @message = @chat.messages.build(body: params[:message][:body], user_id: current_user.id)
    @message.save
    ChatChannel.broadcast_to @chat, message: render_to_string(@message)
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
end
