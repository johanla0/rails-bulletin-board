# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    show_all? || user_is_owner? || record.published?
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
    update? && user_is_owner?
  end

  def archive?
    update? && user_is_owner?
  end

  def publish?
    false
  end

  def reject?
    false
  end

  def may_perform_moderator_actions?
    update? && user.admin?
  end

  def show_all?
    user.present? && user.admin?
  end

  private

  def user_is_owner?
    record.user == user
  end
end
