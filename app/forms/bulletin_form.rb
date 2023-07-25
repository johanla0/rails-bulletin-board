# frozen_string_literal: true

class BulletinForm < Bulletin
  include ActiveFormModel

  permit :title, :description, :image

  validates :title, :description, :image, presence: true
  validates_length_of :title, maximum: 50
  validates_length_of :description, maximum: 1000
end
