# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present?
  end

  def new?
    create?
  end

  def update?
    user.present?
  end

  def edit?
    update?
  end

  def to_moderate?
    update?
  end

  def publish?
    update? && user.admin?
  end

  def reject?
    update? && user.admin?
  end

  def archive?
    update? && (user.admin? || owner?)
  end

  def may_perform_moderator_actions?
    update? && user.admin?
  end

  def show_all?
    user.present? && user.admin?
  end

  private

  def owner?
    record.user == user
  end
end
