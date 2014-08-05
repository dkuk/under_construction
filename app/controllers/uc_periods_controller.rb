class UcPeriodsController < ApplicationController

  layout 'admin'

  before_filter :require_admin, :except => [:add_restriction, :update_msg_head, :under_construction]

  def index
    @uc_period = find_default_period
    if @uc_period.nil?
      @uc_period = UcPeriod.new
    end
    @routes = UcRoute.routes
    @controllers ||= UcRoute.controllers
    Rails.logger.debug "<<<< @controllers = #{@controllers}"
    render 'show'
  end

  def add_restriction
    @uc_period = UcPeriod.find(params[:id])
    @routes = UcRoute.routes
    @controllers ||= UcRoute.controllers

    render 'add_restriction'
  end

  def update_msg_head
    @uc_period = UcPeriod.new(params[:uc_period])
    render :partial => 'update_msg_head'
  end

  def create
    Rails.logger.debug "<<<< #{params[:uc_period]}"
    @uc_period = UcPeriod.new(params[:uc_period])

    respond_to do |format|
      if @uc_period.save
        @uc_period.notify_users if params[:notify_users]
        flash[:notice] = l(:notice_tech_period_saved)
        format.html { redirect_to(:action => 'index') }
      else
        format.html { render 'show' }
      end
    end
  end

  def update
    @uc_period = UcPeriod.find(params[:id])

    respond_to do |format|
      if @uc_period.update_attributes(params[:uc_period])
        @uc_period.notify_users if @uc_period.notify
        flash[:notice] = l(:notice_tech_period_saved)
        format.html { redirect_to(:action => 'index') }
      else
        format.html { render 'show' }
      end
    end
  end

  def under_construction
    @uc_period = find_default_period
    render 'under_construction', :layout => false
  end

  def preview
    @uc_period = UcPeriod.new(params[:uc_period])
    @notes = (@uc_period.txt_to_notify || @uc_period.custom_message).to_s
    render 'preview.html', layout: false
  end

  private
    def find_default_period
      @uc_period = UcPeriod.includes(controller_restrictions: [:action_restrictions]).order('begin_date desc').first
      if @uc_period.controller_restrictions.blank?
        cr = ControllerRestriction.new(uc_period_id: @uc_period)
        @uc_period.controller_restrictions << cr
      end
      @uc_period.controller_restrictions.each do |cr|
        if cr.action_restrictions.blank?
          ar = ActionRestriction.new(controller_restriction_id: cr)
          cr.action_restrictions << ar
        end
      end
      @uc_period
    end

    def require_admin
      render_403 unless User.current.admin?
    end

end
