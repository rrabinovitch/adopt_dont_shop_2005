class Pet < ApplicationRecord
  validates_presence_of :name, :description, :sex, :age
  belongs_to :shelter
end
