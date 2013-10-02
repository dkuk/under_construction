module UnderConstruction
  module ApplicationControllerPatch
    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)  
  
      base.class_eval do
        before_filter :check_under_construction
      end
    end
  
    module ClassMethods   
    end
  
    module InstanceMethods

      def check_under_construction
        return true if User.current.admin? || params[:controller] == 'account'
        @uc_period = UcPeriod.order("begin_date desc").first

        if @uc_period && @uc_period.active?
          render 'uc_periods/under_construction', :layout => false
        end
      end

    end
  
  end
end