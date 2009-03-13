class LiveValidatorAssetsGenerator < Rails::Generator::Base
  def initialize(runtime_args, runtime_options = {})
    super
  end

  def manifest
    record do |m|
      m.file "guilded.live_validator.js", "public/javascripts/guilded.live_validator.js"
      m.file "guilded.live_validator.min.js", "public/javascripts/guilded.live_validator.min.js"
      m.file "livevalidation-1.3.min.js", "public/javascripts/livevalidation-1.3.min.js"
      m.directory "public/stylesheets/guilded/live_validator"
      m.directory "public/stylesheets/guilded/live_validator/default"
      m.file "default.css", "public/stylesheets/guilded/live_validator/default.css"
    end
  end
end