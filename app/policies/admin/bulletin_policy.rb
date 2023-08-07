class Admin::BulletinPolicy < ApplicationPolicy
  def index?
    user.present? && user.admin?
  end
end
