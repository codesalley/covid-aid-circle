class MessagesController < ApplicationController
  before_action :authenticate_user
  before_action :set_channel

  def chat
    @chat
    @receiver = User.find_by(id: params[:id])
    @message = Message.new
  end

  def inbox
    @inbox = current_user.chats.order("updated_at DESC")
  end

  def send_message
    @message = @chat.messages.build(body: params[:message][:body], user_id: current_user.id)
    if @message.save
      @chat.update(updated_at: Time.now)
    end
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
