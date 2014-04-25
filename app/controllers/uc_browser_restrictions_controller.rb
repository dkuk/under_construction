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
    if @rule.save
      render 'create'
    else
      render 'errors'
    end
  end

  def update
    if @rule.update_attributes(params[:rule])
      render 'update'
    else
      render 'errors'
    end
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
