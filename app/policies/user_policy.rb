# frozen_string_literal: true

class UserPolicy < ApplicationPolicy
  def show?
    user.present?
  end
end
