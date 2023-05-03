# frozen_string_literal: true

require_relative "lib/rails_permanent_job/version"

Gem::Specification.new do |spec|
  spec.name = "rails_permanent_job"
  spec.version = RailsPermanentJob::VERSION
  spec.authors = ["Paweł Strzałkowski"]
  spec.email = ["pstrzalk@gmail.com"]

  spec.summary = "Permanent job worker runner"
  spec.description = "Run a permanent worker with a list of jobs to do indefinitelly."
  spec.homepage = "https://github.com/pstrzalk/"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/pstrzalk/rails_permanent_job"
  spec.metadata["changelog_uri"] = "https://github.com/pstrzalk/rails_permanent_job/CHANGELOG.md"

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 3.12"
  spec.add_development_dependency "standard", "~> 1.28"
  spec.add_development_dependency "rubocop", "~> 1.50"

  spec.add_dependency "rake", "~> 13"
  spec.add_dependency "serverengine", "~> 2.1"
end
