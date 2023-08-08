# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id              :integer          not null, primary key
#  bulletins_count :integer          default(0)
#  name            :string           not null
#  slug            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Category < ApplicationRecord
  include Presentable
  include CategoryRepository

  has_many :bulletins, dependent: :restrict_with_error
  validates :name, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[id name slug bulletins_count]
  end
end
