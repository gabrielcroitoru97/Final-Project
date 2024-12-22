# == Schema Information
#
# Table name: form_options
#
#  id         :bigint           not null, primary key
#  category   :string
#  name       :string
#  value      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class FormOption < ApplicationRecord
end
