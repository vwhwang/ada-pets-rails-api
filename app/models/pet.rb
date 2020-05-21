class Pet < ApplicationRecord
  validates :name, presence: true
  validates :species, presence: true
  validates :age, presence: true
  validates :age, numericality: true
  validates :owner, presence: true
end
