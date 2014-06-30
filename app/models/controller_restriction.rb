class ControllerRestriction < ActiveRecord::Base
	belongs_to :uc_period
	has_many :action_restrictions, :dependent => :destroy

  accepts_nested_attributes_for :action_restrictions
end