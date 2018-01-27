class Shop < ApplicationRecord
  has_and_belongs_to_many :medicines
end
