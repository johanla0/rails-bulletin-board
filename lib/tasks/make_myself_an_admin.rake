# frozen_string_literal: true

# NOTE: Needed only because of Render limitations for Free plan: have no access to Rails console
namespace :after_deploy do
  desc 'Make myself an admin'
  task make_myself_an_admin: :environment do
    User.where(email: 'idlhero@gmail.com').update(admin: true)
  end
end
