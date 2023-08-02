# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Category < ApplicationRecord
  has_many :bulletins, dependent: :nullify

  include CategoryRepository

  def self.ransackable_attributes(auth_object = nil)
    %w[id name slug]
  end
end
