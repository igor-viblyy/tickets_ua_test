# == Schema Information
#
# Table name: conversations
#
#  id          :integer          not null, primary key
#  author_id   :integer
#  receiver_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Conversation, type: :model do
  context "Association" do
    it { should belong_to(:author).class_name('User') }
    it { should belong_to(:receiver).class_name('User') }
    it { should have_many(:personal_messages).order(created_at: :asc).dependent(:destroy) }
  end

  # context "Validation" do
  #   it { should validate_uniqueness_of(:author) }
  # end
end
