# frozen_string_literal: true

class Web::Admin::ApplicationController < Web::ApplicationController
  private

  def policy_scope(scope)
    super([:admin, scope])
  end

  def authorize(record, query = nil)
    super([:admin, record], query)
  end
end
