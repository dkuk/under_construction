class UcBrowserRestriction < ActiveRecord::Base
  unloadable

  # BROWSERS = { 'ie' => 'Internet Explorer',
  #              'firefox' => 'FireFox',
  #              'chrome' => 'Google Chrome',
  #              'safari' => 'Safari',
  #              'opera' => 'Opera',
  #              'other' => 'Other Browsers'}

  BR_CONDITIONS = ['', '=', '>', '<']

  validate :version_if_condition

  def version_if_condition
    errors.add(:base, l(:error_cant_store_rule_without_version_if_condition)) if condition.to_s != '' && version.to_s == ''
  end
end