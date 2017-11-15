# == Schema Information
#
# Table name: admins
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

RSpec.describe Admin, type: :model do
  let(:admin) { build (:admin) }

  context "Valid admin data" do
    it "Should email is present" do
      admin.email = "admin@example.com"
      expect(admin.email).to eq("admin@example.com")
    end

    it "Should password is present" do
      admin.password = "password"
      expect(admin.password).to eq("password")
    end
  end

  context "Invalid admin data" do
    it "not valid admin email" do
      admin.email = "admin.example.com"
      expect(admin.email).to_not eq("admin@example.com")
    end

    it "not valid admin password" do
      admin.password = ""
      expect(admin.password).to_not eq("password")
    end
  end
end
