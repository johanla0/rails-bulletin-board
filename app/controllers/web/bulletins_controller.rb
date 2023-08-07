# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  def index
    authorize(Bulletin)

    @q = Bulletin.published.ransack(params[:q])
    @q.sorts = 'updated_at asc' if @q.sorts.empty?
    @bulletins = @q.result(distinct: true).page(params[:page])
  end

  def show
    @bulletin = Bulletin.find(params[:id])
  end

  def new
    @bulletin = BulletinForm.new
  end

  def edit
    bulletin = Bulletin.find(params[:id])
    @bulletin = bulletin.becomes(BulletinForm)
  end

  def create
    @bulletin = BulletinForm.new(params[:bulletin_form])
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
    @bulletin = bulletin.becomes(BulletinForm)

    @bulletin.assign_attributes(params[:bulletin_form])

    if @bulletin.valid?
      @bulletin.to_moderate if @bulletin.published? || @bulletin.rejected?
      @bulletin.save!
      f :success, redirect: bulletin_path(@bulletin)
    else
      f :error, now: true, render: :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bulletin = Bulletin.find(params[:id])
    @bulletin.destroy

    f :success, redirect: root_path
  end

  def change_state
    bulletin = Bulletin.find(params[:id])

    bulletin = bulletin.becomes(BulletinStateForm)
    bulletin.aasm.fire params[:state_event]

    if bulletin.valid?
      bulletin.save!
      f :success, redirect: bulletin_path(bulletin)
    else
      f :error, redirect_back: true, redirect: bulletin_path(bulletin), status: :unprocessable_entity
    end
  end
end
