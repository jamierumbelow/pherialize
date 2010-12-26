require 'lib/pherialize'

Gem::Specification.new do |spec|
  spec.name = "pherialize"
  spec.version = Pherialize::VERSION
  spec.summary = "A Ruby parser/writer for the PHP serialization format"
  spec.require_path = 'lib/'
  spec.files = Dir['lib/*.rb']
  spec.test_files = Dir['tests/test_*.rb']
  spec.author = "Jamie Rumbelow"
  spec.email = "jamie@jamierumbelow.net"
  spec.homepage = "http://github.com/jamierumbelow/pherialize/"
  spec.description = <<-EOF
  Pherialize is a gem for quick and easy serialisation to and from PHP's native serialisation format. 
  It not only aims to perfectly parse all output from PHP's serialize() method, but also define a specification and try to standardise it.
  EOF
  spec.has_rdoc = true
end