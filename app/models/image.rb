# == Schema Information
#
# Table name: images
#
#  id          :bigint           not null, primary key
#  picture     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  location_id :integer
#  poster_id   :integer
#
class Image < ApplicationRecord

  belongs_to :location, required: true, class_name: "WorkLocation", foreign_key: "location_id"
  belongs_to :poster, required: true, class_name: "User", foreign_key: "poster_id"
  has_one_attached :picture

  validates :poster_id, presence: true
  validates :location_id, presence: true
  
  # Update to allow optional presence of a picture for new records
  validates :picture, presence: true, on: :create

end
