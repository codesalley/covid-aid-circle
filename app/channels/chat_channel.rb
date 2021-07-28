class ChatChannel < ApplicationCable::Channel
  def subscribed
    stop_all_streams
    stream_for Chat.find_by(title: params[:id])
  end

  def unsubscribed
    stop_all_streams
  end
end
