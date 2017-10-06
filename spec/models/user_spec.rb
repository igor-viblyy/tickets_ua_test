# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  context "Association" do
    it { should have_many(:personal_messages).dependent(:destroy) }
    it {should have_many(:authored_conversations).class_name('Conversation').with_foreign_key(:author_id) }
    it { should have_many(:received_conversations).class_name('Conversation').with_foreign_key(:received_id) }
  end

  it "#name" do
    user = 'user@example.com'
    name = user.split('@')[0]
    expect(name).to eq('user')
  end

  context "Valid user data" do
    it "should email is present" do
      user.email = 'user@example.com'
      expect(user.email).to eq('user@example.com')
    end

    it "should password is present" do
      user.password = 'password'
      expect(user.password).to eq('password')
    end
  end

  context "Invalid user data" do
    it "should is not valid user email" do
      user.email = 'user.example.com'
      expect(user.email).to_not eq('user@example.com')
    end

    it "should is not valid user password" do
      user.password = ''
      expect(user.password).to_not eq('password')
    end
  end
end
