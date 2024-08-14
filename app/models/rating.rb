# == Schema Information
#
# Table name: ratings
#
#  id             :bigint           not null, primary key
#  content        :text
#  crowding_score :integer
#  noise_level    :integer
#  stars          :integer
#  wifi_rating    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  location_id    :integer
#  user_id        :integer
#
class Rating < ApplicationRecord
  belongs_to :location, required: true, class_name: "WorkLocation", foreign_key: "location_id"
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"

  validates :user_id, presence: true
  validates :stars, presence: true
  validates :location_id, presence: true



end
