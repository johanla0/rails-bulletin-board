# frozen_string_literal: true

class SetDefaultAdminForUsers < ActiveRecord::Migration[7.0]
  def up
    User.where(admin: nil).each { |u| u.update(admin: false) }
  end

  def down; end
end
