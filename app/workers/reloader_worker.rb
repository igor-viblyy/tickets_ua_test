class ReloaderWorker
  include Sidekiq::Worker
  # queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    @conversations = Conversation.participating(user).order('updated_at DESC').reload
  end

end
