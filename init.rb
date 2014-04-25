# require_dependency 'application_helper'
# require_dependency 'project'
# require_dependency 'principal'
# require_dependency 'user'

Redmine::Plugin.register :under_construction do
  name 'Under Construction'
  author 'Danil Kukhlevskiy'
  description 'This is a plugin for temporary disable RM'
  version '0.0.1'
  url 'http://rmplus.pro'
  author_url 'http://rmplus.pro'


  menu :admin_menu, :admin_menu_under_construction, { :controller => 'uc_periods', :action => 'index'}, :caption => :admin_menu_under_construction
  menu :admin_menu, :admin_menu_browsers_restricitons, '/settings/plugin/under_construction', :caption => :admin_menu_browsers_restricitons

  settings  partial: 'settings/uc_settings'
end

require 'under_construction/view_hooks'

Rails.application.config.to_prepare do
  ApplicationController.send(:include, UnderConstruction::ApplicationControllerPatch)
end