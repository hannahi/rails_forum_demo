class MessagesController < ApplicationController

  # GET /messages
  def index
    @messages = Message.all
    @message = Message.new
  end

  # POST /messages
  def create
    @messages = Message.all
    @message = Message.new(message_params)
    @message.user_id = current_user.id
    respond_to do |format|
      if @message.save
        format.js   {}
      end
    end
  end

  private

    def message_params
      params.require(:message).permit(:content, :user_id)
    end
end
