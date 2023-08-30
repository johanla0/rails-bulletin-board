# frozen_string_literal: true

class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def index
    @q = Bulletin.ransack(params[:q])
    @q.sorts = 'title asc' if @q.sorts.empty?
    @bulletins = @q.result(distinct: true).page(params[:page])
  end

  def archive
    bulletin = Bulletin.find(params[:id])
    bulletin.archive

    if bulletin.valid?
      bulletin.save!
      # NOTE: status :see_other to pass specific Hexlet test
      f :success,
        turbo_stream: [
          turbo_stream.replace(
            helpers.dom_id(bulletin, :admin_buttons),
            partial: 'web/admin/bulletins/shared/action_buttons',
            locals: { bulletin: }
          ),
          turbo_stream.replace(
            helpers.dom_id(bulletin, :state),
            partial: 'web/bulletins/shared/state',
            locals: { bulletin: }
          )
        ], status: :see_other
    else
      f :error, redirect_back: true, redirect: bulletin_path(bulletin), status: :unprocessable_entity
    end
  end

  def publish
    bulletin = Bulletin.find(params[:id])
    bulletin.publish

    if bulletin.valid?
      bulletin.save!
      # NOTE: status :see_other to pass specific Hexlet test
      f :success,
        turbo_stream: [
          turbo_stream.replace(
            helpers.dom_id(bulletin, :admin_buttons),
            partial: 'web/admin/bulletins/shared/action_buttons',
            locals: { bulletin: }
          ),
          turbo_stream.replace(
            helpers.dom_id(bulletin, :state),
            partial: 'web/bulletins/shared/state',
            locals: { bulletin: }
          )
        ], status: :see_other
    else
      f :error, redirect_back: true, redirect: bulletin_path(bulletin), status: :unprocessable_entity
    end
  end

  def reject
    bulletin = Bulletin.find(params[:id])
    bulletin.reject

    if bulletin.valid?
      bulletin.save!
      # NOTE: status :see_other to pass specific Hexlet test
      f :success,
        turbo_stream: [
          turbo_stream.replace(
            helpers.dom_id(bulletin, :admin_buttons),
            partial: 'web/admin/bulletins/shared/action_buttons',
            locals: { bulletin: }
          ),
          turbo_stream.replace(
            helpers.dom_id(bulletin, :state),
            partial: 'web/bulletins/shared/state',
            locals: { bulletin: }
          )
        ], status: :see_other
    else
      f :error, redirect_back: true, redirect: bulletin_path(bulletin), status: :unprocessable_entity
    end
  end
end
