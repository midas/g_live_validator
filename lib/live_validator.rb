$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'live_validator/view_helpers'

module LiveValidator
  VERSION = '0.0.1'
end

if defined?( ActiveRecord )
  ActiveRecord::Base.class_eval do
    include BoilerPlate::ActiveRecordExtensions::ValidationReflection
  end
end

ActionView::Base.send( :include, LiveValidator::ViewHelpers ) if defined?( ActionView )