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
    @bulletin = Bulletin.new
  end

  def edit
    @bulletin = Bulletin.find(params[:id])
  end

  def create
    @bulletin = Bulletin.new(bulletin_params)

    if @bulletin.save
      f :success, redirect: bulletin_path(@bulletin)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @bulletin = Bulletin.find(params[:id])

    if @bulletin.update(bulletin_params)
      f :success, redirect: bulletin_path(@bulletin)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bulletin = Bulletin.find(params[:id])
    @bulletin.destroy

    f :success, redirect: root_path
  end

  private

  def bulletin_params
    params.fetch(:bulletin, {})
  end
end
