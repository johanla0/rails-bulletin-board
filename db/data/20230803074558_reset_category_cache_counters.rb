# frozen_string_literal: true

class ResetCategoryCacheCounters < ActiveRecord::Migration[7.0]
  def up
    Category.all.each { |c| Category.reset_counters(c.id, :bulletins) }
  end

  def down; end
end
