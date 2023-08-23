# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    show_all? || user_is_owner? || record.published?
  end

  def update?
    (user.present? && user_is_owner?) || user.admin?
  end

  def edit?
    update?
  end

  def to_moderate?
    update?
  end

  def archive?
    update?
  end

  def publish?
    false
  end

  def reject?
    false
  end

  def show_all?
    user&.admin?
  end

  private

  def user_is_owner?
    record.user == user
  end
end
