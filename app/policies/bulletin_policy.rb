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

  def change_state?
    update? && user.admin?
  end

  alias may_perform_moderator_actions? change_state?

  def show_all?
    user.present? && user.admin?
  end
end
