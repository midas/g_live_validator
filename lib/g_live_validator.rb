$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'g_live_validator/view_helpers'
require 'g_live_validator/validation_definition'
require 'g_live_validator/active_record_extensions'

module GLiveValidator
  VERSION = '1.0.5'
end

if defined?( ActiveRecord::Base )
  ActiveRecord::Base.class_eval do
    include GLiveValidator::ActiveRecordExtensions::ValidationReflection
  end
end

if defined?( InactiveRecord::Base )
  InactiveRecord::Base.class_eval do
    include GLiveValidator::ActiveRecordExtensions::ValidationReflection
  end
end

if defined?( ActionView::Base )
  ActionView::Base.send( :include, GLiveValidator::ViewHelpers ) unless ActionView::Base.include?( GLiveValidator::ViewHelpers )
end