# == Schema Information
#
# Table name: work_locations
#
#  id                :bigint           not null, primary key
#  address           :string
#  average_rating    :float
#  city              :string
#  crowding_average  :integer
#  description       :text
#  latitude          :string
#  longitude         :string
#  membership        :boolean
#  name              :string
#  noise_average     :integer
#  phone_number      :string
#  requires_purchase :boolean
#  state             :string
#  website           :string
#  weekday_closing   :time
#  weekday_opening   :time
#  weekend_closing   :time
#  weekend_opening   :time
#  wifi_speed        :integer
#  zip_code          :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  location_type_id  :integer
#  owner_id          :integer
#
class WorkLocation < ApplicationRecord

  has_many  :comments, class_name: "Comment", foreign_key: "location_id", dependent: :destroy
  has_many  :ratings, class_name: "Rating", foreign_key: "location_id", dependent: :destroy
  has_many  :images, class_name: "Image", foreign_key: "location_id", dependent: :destroy
  has_many  :favorite_places, class_name: "FavoritePlace", foreign_key: "place_id", dependent: :destroy
  belongs_to :owner, required: true, class_name: "User", foreign_key: "owner_id"
  belongs_to :location_type, required: true, class_name: "LocationType", foreign_key: "location_type_id"

  validates :zip_code, presence: true
  validates :state, presence: true
  validates :name, presence: true
  #validates :longitude, presence: true
  validates :location_type_id, presence: true
  #validates :latitude, presence: true
  validates :city, presence: true
  validates :address, presence: true

  def type
    return LocationType.where({:id=>self.location_type_id}).at(0).descriptor
  end

end
