class MessagesController < ApplicationController
  def index
    # Fetch messages for the current user and the selected user
    @messages = Message.where(sender_id: [current_user.id, params[:receiver_id]])
                      .or(Message.where(receiver_id: [current_user.id, params[:receiver_id]]))
                      .order(:created_at)
    render json: @messages
  end

  def create
    @message = Message.new
    @message.reciver_id = params[:sendTo].to_i
    @message.sender_id = params[:sendBy].to_i
    @message.message_image = params[:image]

    if @message.save
      render json: @message, root: "data", each_serializer: MessageSerializer, adapter: :json
      # render json: @message, MessagesSerializer
    else
      render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:receiver_id, :text)
  end

end