# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def show?
    self?
  end

  private

  def self?
    record == user
  end
end
