# frozen_string_literal: true

class Admin::BulletinPolicy < ApplicationPolicy
  def index?
    user.present? && user.admin?
  end

  def archive?
    user.present? && user.admin?
  end

  def reject?
    user.present? && user.admin?
  end

  def to_moderate?
    user.present? && user.admin?
  end

  def publish?
    user.present? && user.admin?
  end
end
