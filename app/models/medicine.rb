class Medicine < ApplicationRecord
  has_and_belongs_to_many :shops
end
