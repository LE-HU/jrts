class Event < ApplicationRecord
  has_many :tickets
  has_many :users, through: :appointments
end
