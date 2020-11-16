class MessagesController < ApplicationController
  @chatroom = Chatroom.find(params[:chatroom_id])
  @message = Message.new(message_params)
  @message.chatroom = @chatroom
  @message.user = current_user
  if @message.save
    # app/controllers/messages_controller.rb
    ChatroomChannel.broadcast_to(
      @chatroom,
      render_to_string(partial: "message", locals: { message: @message })
    )
    redirect_to chatroom_path(@chatroom, achor: "message-#{@message.id}")
  else
    render "chatrooms/show"
  end
end
