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

class User < ApplicationRecord
  has_many :authored_conversations, class_name: 'Conversation', foreign_key: 'author_id'

  has_many :received_conversations, class_name: 'Conversation', foreign_key: 'received_id'

  has_many :personal_messages, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  @skip = false

  def skip_notifications!()
    skip_confirmation_notification!
    @skip = true
  end

  def email_changed?
    return false if @skip
    super
  end

  def encrypted_password_changed?
    return false if @skip
    super
  end

  def name
    email.split('@')[0]
  end
end
