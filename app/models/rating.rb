class Rating < ApplicationRecord
  belongs_to :location, required: true, class_name: "WorkLocation", foreign_key: "location_id"
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"

  validates :user_id, presence: true
  validates :stars, presence: true
  validates :location_id, presence: true
end
