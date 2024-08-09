class Image < ApplicationRecord

  belongs_to :location, required: true, class_name: "WorkLocation", foreign_key: "location_id"
  belongs_to :poster, required: true, class_name: "User", foreign_key: "poster_id"

  validates :poster_id, presence: true
  validates :picture, presence: true
  validates :location_id, presence: true

end
