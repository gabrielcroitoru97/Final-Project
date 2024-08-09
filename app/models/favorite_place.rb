class FavoritePlace < ApplicationRecord

  belongs_to :place, required: true, class_name: "WorkLocation", foreign_key: "place_id"
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
  has_one  :owner, through: :place, source: :owner

end
