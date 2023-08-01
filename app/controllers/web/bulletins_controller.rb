# frozen_string_literal: true

class Web::BulletinsController < Web::ApplicationController
  def index
    authorize(Bulletin)
    @bulletins = Bulletin.all.includes([:image_attachment])
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

    if @bulletin.save
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
end
