# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{live_validator}
  s.version = "1.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["C. Jason Harrelson (midas)"]
  s.date = %q{2009-03-11}
  s.description = %q{Live validator is a Rails Guilded (http://github.com/midas/guilded/tree/master) component that will reflect ActiveRecord validations  and use them to live validate forms.  Live validator uses the Live Validation (http://www.livevalidation.com) JavaScript library to  accomplish this task.  It also uses an ActiveRecord extension authored by Michael Schuerig to mre easily reflect on the ActiveRecord valdiations.}
  s.email = ["jason@lookforwardenterprises.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "lib/live_validator.rb", "lib/live_validator/active_record_extensions.rb", "lib/live_validator/view_helpers.rb", "live_validator.gemspec", "rails_generators/live_validator_assets/live_validator_assets_generator.rb", "rails_generators/live_validator_assets/templates/guilded.live_validator.js", "rails_generators/live_validator_assets/templates/guilded.live_validator.min.js", "rails_generators/live_validator_assets/templates/livevalidation-1.3.min.js", "script/console", "script/destroy", "script/generate", "spec/live_validator_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/rspec.rake"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/midas/live_validator/tree/master}
  s.post_install_message = %q{PostInstall.txt}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{live_validator}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Live validator is a Rails Guilded (http://github.com/midas/guilded/tree/master) component that will reflect ActiveRecord validations  and use them to live validate forms}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<newgem>, [">= 1.2.3"])
      s.add_development_dependency(%q<midas-guilded>, [">= 0.0.6"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<newgem>, [">= 1.2.3"])
      s.add_dependency(%q<midas-guilded>, [">= 0.0.6"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<newgem>, [">= 1.2.3"])
    s.add_dependency(%q<midas-guilded>, [">= 0.0.6"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
