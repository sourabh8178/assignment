class MessagesController < ApplicationController
  def index
    # Fetch messages for the current user and the selected user
    @messages = Message.where(sender_id: [current_user.id, params[:receiver_id]])
                      .or(Message.where(receiver_id: [current_user.id, params[:receiver_id]]))
                      .order(:created_at)
    render json: @messages
  end

  def create
    @message = Message.new(message_params)
    @message.sender_id = current_user.id

    if @message.save
      # Broadcast the message to connected clients
      socket_broadcast('chat', @message)
      render json: @message
    else
      render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:receiver_id, :text)
  end

end