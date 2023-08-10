# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  def index
    authorize(Bulletin)

    @q = if user_signed_in? && current_user.admin?
           Bulletin.ransack(params[:q])
         else
           Bulletin.published.ransack(params[:q])
         end
    @q.sorts = 'updated_at asc' if @q.sorts.empty?
    @bulletins = @q.result(distinct: true).page(params[:page])
  end

  def show
    @bulletin = Bulletin.find(params[:id])
    authorize(@bulletin)
  end

  def new
    authorize(Bulletin)

    @bulletin = BulletinForm.new
  end

  def edit
    bulletin = Bulletin.find(params[:id])
    authorize(bulletin)

    @bulletin = bulletin.becomes(BulletinForm)
  end

  def create
    authorize(Bulletin)

    @bulletin = BulletinForm.new(params[:bulletin])
    @bulletin.user = current_user

    if @bulletin.valid?
      @bulletin.save!
      f :success, redirect: bulletin_path(@bulletin)
    else
      f :error, now: true, render: :new, status: :unprocessable_entity
    end
  end

  def update
    bulletin = Bulletin.find(params[:id])
    authorize(bulletin)

    @bulletin = bulletin.becomes(BulletinForm)
    @bulletin.assign_attributes(params[:bulletin])

    if @bulletin.valid?
      @bulletin.to_moderate if @bulletin.published?
      @bulletin.save!
      f :success, redirect: bulletin_path(@bulletin)
    else
      f :error, now: true, render: :edit, status: :unprocessable_entity
    end
  end

  def change_state
    bulletin = Bulletin.find(params[:id])
    authorize(bulletin)

    bulletin = bulletin.becomes(BulletinStateForm)
    bulletin.aasm.fire params[:state_event]

    if bulletin.valid?
      bulletin.save!
      # NOTE: status :see_other to pass Hexlet test
      f :success,
        turbo_stream: [
          turbo_stream.replace(
            helpers.dom_id(bulletin, :buttons),
            partial: 'web/admin/bulletins/shared/action_buttons',
            locals: { bulletin: }
          ),
          turbo_stream.replace(
            helpers.dom_id(bulletin, :state),
            partial: 'web/admin/bulletins/state',
            locals: { bulletin: }
          )
        ], status: :see_other
    else
      f :error, redirect_back: true, redirect: bulletin_path(bulletin), status: :unprocessable_entity
    end
  end
end
