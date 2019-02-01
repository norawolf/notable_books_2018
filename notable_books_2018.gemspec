
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "notable_books_2018/version"

Gem::Specification.new do |spec|
  spec.name          = "notable_books_2018"
  spec.version       = NotableBooks2018::VERSION
  spec.authors       = ["norawolf"]
  spec.email         = ["noraevogt@gmail.com"]
  spec.files         = Dir['lib/notable_books_2018/*.rb'] + Dir['bin/*'] + Dir['lib/environment.rb'] + Dir['[A-Z]*']
  spec.summary       = %q{A gem to browse the New York Times' Notable Books of 2018 list.}
  spec.homepage      = "https://github.com/norawolf/notable_books_2018.git"
  spec.license       = "MIT"
  spec.required_ruby_version = '~> 2.0'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "Set to 'http://rubygems.org'"
  #   spec.metadata["homepage_uri"] = spec.homepage
  #   spec.metadata["source_code_uri"] = "https://github.com/norawolf/notable_books_2018"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry", "~>0.1"

  spec.add_dependency "nokogiri", "~> 1.0"
  spec.add_dependency "paint", "~> 2.0"
end
