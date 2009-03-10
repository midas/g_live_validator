class LiveValidatorAssetsGenerator < Rails::Generator::Base
  def initialize(runtime_args, runtime_options = {})
    super
  end

  def manifest
    record do |m|
      m.file "guilded.live_validator.js", "public/javascripts/guilded.live_validator.js"
      #m.directory "public/stylesheets/guilded"
      #m.directory "public/stylesheets/guilded/flash_growler"
      #m.directory "public/stylesheets/guilded/flash_growler/default"
      m.file "livevalidation-1.3.compressed.js", "public/javascripts/livevalidation-1.3.compressed.js"
    end
  end
end