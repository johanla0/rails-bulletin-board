# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def show?
    record.published? || user_is_owner? || show_all?
  end

  def update?
    user_is_owner? || user.admin?
  end

  def to_moderate?
    update?
  end

  def archive?
    update?
  end

  def show_all?
    user&.admin?
  end

  private

  def user_is_owner?
    record.user == user
  end
end
