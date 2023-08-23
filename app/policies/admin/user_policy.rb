# frozen_string_literal: true

class Admin::UserPolicy < ApplicationPolicy
  ACTIONS = %i[index archive reject to_moderate publish create new update edit destroy].freeze

  ACTIONS.each do |action|
    define_method "#{action}?" do
      user&.admin?
    end
  end
end
