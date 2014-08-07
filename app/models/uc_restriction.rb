class UcRestriction < ActiveRecord::Base
	belongs_to :uc_period

  attr_accessible :controller, :action, :timestamps
end