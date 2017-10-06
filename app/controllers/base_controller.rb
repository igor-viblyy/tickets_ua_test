class BaseController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = Conversation.participating(current_user).order('updated_at DESC')

    @count = @conversations.count

  end
end
