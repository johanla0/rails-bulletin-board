# frozen_string_literal: true

class SetDefaultStateToBulletins < ActiveRecord::Migration[7.0]
  def up
    Bulletin.where(state: nil).each { |b| b.update(state: :draft) }
  end

  def down; end
end
