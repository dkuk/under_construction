class UcRestrictionsController < ApplicationController

  before_filter :require_admin

  def destroy
    if params[:id].present?
      @uc_restriction = UcRestriction.find(params[:id])
      @uc_restriction.destroy
    end
    @tr_id = params[:tr_id]
  end

end