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
      redirect_to bulletin_url(@bulletin), notice: 'Bulletin was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @bulletin = Bulletin.find(params[:id])

    if @bulletin.update(bulletin_params)
      redirect_to bulletin_url(@bulletin), notice: 'Bulletin was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @bulletin = Bulletin.find(params[:id])
    @bulletin.destroy

    redirect_to bulletins_url, notice: 'Bulletin was successfully destroyed.'
  end

  private

  def bulletin_params
    params.fetch(:bulletin, {})
  end
end
