class LiveValidatorAssetsGenerator < Rails::Generator::Base
  def initialize(runtime_args, runtime_options = {})
    super
  end

  def manifest
    record do |m|
      m.file "guilded.live_validator.js", "public/javascripts/guilded.live_validator.js"
      m.file "guilded.live_validator.min.js", "public/javascripts/guilded.live_validator.min.js"
      m.file "livevalidation-1.3.min.js", "public/javascripts/livevalidation-1.3.min.js"
    end
  end
end