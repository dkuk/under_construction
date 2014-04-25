class UcBrowserRestrictionsController < ApplicationController

  layout 'admin'

  before_filter :require_admin, :except => [:wrong_browser]
  before_filter :find_rule, :only => [:edit, :update, :destroy]

  def new
    @rule = UcBrowserRestriction.new
    render partial: 'form'
  end

  def edit
    render partial: 'form'
  end

  def create
    @rule = UcBrowserRestriction.new(params[:rule])
    @rule.save
  end

  def update
    @js_err = l(:error_rule_not_saved) unless @rule.update_attributes(params[:rule])
  end

  def destroy
    @rule.destroy
  end

  def wrong_browser
    render 'wrong_browser', :layout => false
  end

  private

  def require_admin
    render_403 unless User.current.admin?
  end

  def find_rule
    @rule = UcBrowserRestriction.find(params[:id])
  end

end
