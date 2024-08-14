# == Schema Information
#
# Table name: favorite_places
#
#  id         :bigint           not null, primary key
#  note       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  place_id   :integer
#  user_id    :integer
#
class FavoritePlace < ApplicationRecord

  belongs_to :place, required: true, class_name: "WorkLocation", foreign_key: "place_id"
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
  has_one  :owner, through: :place, source: :owner

  def user
    return User.where({:id=>self.user_id}).at(0)
  end

  def place
    return WorkLocation.where({:id=>self.place_id}).at(0)
  end

end
