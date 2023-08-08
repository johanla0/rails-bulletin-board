# frozen_string_literal: true

class Admin::BulletinPolicy < ApplicationPolicy
  def index?
    user.present? && user.admin?
  end
end
