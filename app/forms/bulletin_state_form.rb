# frozen_string_literal: true

class BulletinStateForm < Bulletin
  include ActiveFormModel

  permit :state_event
end
