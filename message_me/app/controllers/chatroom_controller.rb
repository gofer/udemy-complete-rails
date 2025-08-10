class ChatroomController < ApplicationController
  def index
    @messages = Message.includes(:user).all
  end
end
