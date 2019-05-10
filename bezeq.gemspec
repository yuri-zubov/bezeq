
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "bezeq/version"

Gem::Specification.new do |spec|
  spec.name          = "bezeq"
  spec.version       = Bezeq::VERSION
  spec.authors       = ["Yuri Zubov"]
  spec.email         = ["y.zubov@sumatosoft.com"]

  spec.summary       = %q{Sender sms via bezeq}
  spec.description   = %q{Sender sms via bezeq}
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_runtime_dependency 'activesupport', '>= 4.2'
  spec.add_runtime_dependency 'nokogiri', '>= 1'
end
