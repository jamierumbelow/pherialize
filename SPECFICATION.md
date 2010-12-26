Pherialize PHP serialization specification
==========================================

This document aims to fully standardise and specify the PHP serialization format. It hopes to be 100% compatible with [PHP's native serialize() and unserialize() methods](http://php.net/serialize).

Generic Syntax
--------------

Serialized PHP takes the form of a string that specifies a single object or variable. Only one object or variable can be serialised at once. Using data structures such as associative arrays and classes, richer data structures can be serialized. While some data types have a specific definition syntax, the generic form is as follows:

	TYPE_IDENIFIER:[LENGTH:][CLASS:][LENGTH:]VALUE
	
`TYPE_IDENIFIER` is a single character that represents the data type. `LENGTH` is a conditional integer that represents the length of the value. The length is unnecessary for integer values, and represents slightly different things depending on the data type. `VALUE` is the value of the variable. `CLASS` is only used to specify which class is used when serializing an object.

Data Types
----------

Here is a list of allowed data types. Different versions of PHP capitalise these, so it's recommended that you lowercase the `TYPE_IDENTIFIER`.

* `a` - Associative array; data structure that represents *n* number of *key -> value* maps
* `b` - Boolean. TRUE or FALSE (actually 1 or 0)
* `d` - Float
* `i` - Integer
* `n` - NULL
* `o` - Object. Represents a serialized PHP class.
* `r` - Recursion marker. Outputted by PHP when a value is too recursive.
* `s` - String