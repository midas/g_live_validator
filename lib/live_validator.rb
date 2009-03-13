$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'live_validator/view_helpers'
require 'live_validator/active_record_extensions'

module LiveValidator
  VERSION = '1.0.2'
end

if defined?( ActiveRecord::Base )
  ActiveRecord::Base.class_eval do
    include LiveValidator::ActiveRecordExtensions::ValidationReflection
  end
end

if defined?( ActionView::Base )
  ActionView::Base.send( :include, LiveValidator::ViewHelpers ) unless ActionView::Base.include?( LiveValidator::ViewHelpers )
end