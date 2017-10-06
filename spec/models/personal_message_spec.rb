# == Schema Information
#
# Table name: personal_messages
#
#  id              :integer          not null, primary key
#  body            :text
#  conversation_id :integer
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe PersonalMessage, type: :model do
  context "Association" do
    it { should belong_to(:conversation) }
    it { should belong_to(:user) }
  end

  context "Validate" do
    it { validate_presence_of(:body) }
  end
end
