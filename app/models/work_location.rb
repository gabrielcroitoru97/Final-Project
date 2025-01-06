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
#  friday_closing    :time
#  friday_opening    :time
#  latitude          :float
#  longitude         :float
#  membership        :boolean
#  monday_closing    :time
#  monday_opening    :time
#  name              :string
#  noise_average     :integer
#  phone_number      :string
#  requires_purchase :boolean
#  saturday_closing  :time
#  saturday_opening  :time
#  state             :string
#  sunday_closing    :time
#  sunday_opening    :time
#  thursday_closing  :time
#  thursday_opening  :time
#  tuesday_closing   :time
#  tuesday_opening   :time
#  website           :string
#  wednesday_closing :time
#  wednesday_opening :time
#  wifi_speed        :integer
#  zip_code          :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  location_type_id  :integer
#  owner_id          :integer
#
class WorkLocation < ApplicationRecord

  # Associations
  has_many  :comments, class_name: "Comment", foreign_key: "location_id", dependent: :destroy
  has_many  :ratings, class_name: "Rating", foreign_key: "location_id", dependent: :destroy
  has_many  :images, class_name: "Image", foreign_key: "location_id", dependent: :destroy
  has_many  :favorite_places, class_name: "FavoritePlace", foreign_key: "place_id", dependent: :destroy
  belongs_to :owner, required: true, class_name: "User", foreign_key: "owner_id"
  belongs_to :location_type, required: true, class_name: "LocationType", foreign_key: "location_type_id"

  # Validations
  validates :zip_code, presence: true
  validates :state, presence: true
  validates :name, presence: true
  validates :location_type_id, presence: true
  validates :city, presence: true
  validates :address, presence: true
  validates :phone_number, format: { with: /\A\d{10}\z/, message: "must be 10 digits" }, allow_blank: true

  validate :opening_before_closing

  # Geocoding Setup
  geocoded_by :full_address
  after_validation :geocode, if: ->(obj) { obj.address_changed? || obj.city_changed? || obj.state_changed? || obj.zip_code_changed? }

  # Instance Methods
  def full_address
    [address, city, state, zip_code].compact.join(', ')
  end

  def type
    LocationType.find_by(id: location_type_id)&.descriptor || "Unknown"
  end

  def hours_for(day)
    opening = send("#{day}_opening")
    closing = send("#{day}_closing")
    opening && closing ? "#{opening.strftime('%I:%M %P')} - #{closing.strftime('%I:%M %P')}" : "Closed"
  end


  def opening_before_closing
    %w[monday tuesday wednesday thursday friday saturday sunday].each do |day|
      opening = send("#{day}_opening")
      closing = send("#{day}_closing")
      if opening && closing && opening >= closing
        errors.add(:base, "#{day.capitalize} opening time must be before closing time")
      end
    end
  end

end
