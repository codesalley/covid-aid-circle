class ChatChannel < ApplicationCable::Channel
  def subscribed
    stop_all_streams
    stream_for Chat.find_by(title: params[:id])
  end

  def unsubscribed
    stop_all_streams
    # Any cleanup needed when channel is unsubscribed
  end
end
