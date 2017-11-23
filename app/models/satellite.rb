class Satellite < ApplicationRecord

  validates :name, presence: true, length: {maximum: 50}, uniqueness: true
  validates :category, presence: true, length: {maximum: 50}, uniqueness: false
  validates :tle1, presence: true, length: {maximum: 255}, uniqueness: false
  validates :tle2, presence: true, length: {maximum: 255}, uniqueness: false

end
