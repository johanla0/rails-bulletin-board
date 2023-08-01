# frozen_string_literal: true

class MakeMyselfAnAdmin < ActiveRecord::Migration[7.0]
  def up
    User.where(email: 'idlhero@gmail.com').update(admin: true)
  end

  def down; end
end
