# == Schema Information
#
# Table name: contact_requests
#
#  id         :bigint           not null, primary key
#  email      :string
#  message    :text
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ContactRequest < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :message, presence: true
end
