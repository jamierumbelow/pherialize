Pherialize: A Ruby PHP serialiser
=================================

Pherialize is a gem for quick and easy serialisation to and from PHP's native serialisation format. It not only aims to perfectly parse all output from PHP's serialize() method, but also define a specification and try to standardise it. It's supposed to be a replacement for [Thomas Hurst's original Ruby PHP serializer](http://www.aagh.net/projects/ruby-php-serialize).

Basic Usage
-----------

Load the gem and try parsing a simple string of serialized PHP:

	require 'pherialize'
	drinks = Pherialize::Parser.parse('a:3:{s:4:"Beer";s:6:"Whisky";s:4:"Wine"}')

The `Pherialize::Parser` class has a few class methods to parse various things.

	drinks = Pherialize::Parser.parse('a:3:{s:4:"Beer";s:6:"Whisky";s:4:"Wine"}')
	drinks = Pherialize::Parser.parse_string('a:3:{s:4:"Beer";s:6:"Whisky";s:4:"Wine"}')
	drinks = Pherialize::Parser.parse_file('/path/to/file.txt')

You can also serialise Ruby objects into the PHP format with `Pherialize::Writer`

	object = {
		:name => "Jamie",
		:age => 16,
		:movies => [ "The Graduate", "Pulp Fiction", "Reservoir Dogs" ]
	}
	
	string = Pherialize::Writer.write(object)