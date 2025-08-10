class ChatroomController < ApplicationController
  before_action :require_user

  def index
    @messages = Message.includes(:user).all
  end
end
