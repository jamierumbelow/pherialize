module Pherialize
  
  # Pherialize::Lexer takes an input string of serialized PHP
  # and replaces it with a series of tokens that Pherialize::Parser
  # can understand. It's usage is simple:
  # 
  #   Pherialize::Lexer.new('s:4:"Cake"')
  class Lexer
    # A big long list of constants for tokens. Each token represents
  	# something meaningful in the code.
    TOKEN_TYPE_IDENITFIER = 1
    TOKEN_STRING = 2
    TOKEN_NUMBER = 3
    TOKEN_END_OBJECT = 4
    
    # Constants used to keep track of the internal state of the lexer
    STATE_DEFAULT = 1
    STATE_VALLENGTH = 2
    STATE_VALUE = 3
    STATE_CLASSLENGTH = 4
    STATE_CLASS = 5
    STATE_STRING = 6
    STATE_NUMBER = 7
    STATE_SKIP = 8
    STATE_SKIP_TO_CLASSLENGTH = 9
    STATE_SKIP_TO_CLASS = 10
    STATE_SKIP_TO_VALLENGTH = 11
    STATE_SKIP_TO_VALUE = 12
    
    # A few other bits
    TYPE_IDENITIFIERS = 'abdinors'
    attr_accessor :tokens
    
    def initialize(source)
      @source = source
      @tokens = []
      
      # Initialise a few variables
      state = STATE_DEFAULT
      @token = ""
      
      # Loop through the string, character by character, building up tokens
      @source.each_char do |char|
        puts "#{char} = #{state}"
        
        case state
          when STATE_DEFAULT
            state = type_identifier_lookup char, state
            
          when STATE_VALUE
            state = type_identifier_lookup char, state
            state = value_lookup char
            
          when STATE_CLASSLENGTH
            # Skip over the length
            if char == ":"
              state = STATE_SKIP_TO_CLASS
            end
          
          when STATE_CLASS
            # Skip over the class
            if char == ":"
              state = STATE_VALLENGTH
            end
            
          when STATE_VALLENGTH
            # Skip over the length
            if char == ":"
              state = STATE_VALUE
            end
            
          when STATE_SKIP
            state = STATE_DEFAULT
            
          when STATE_SKIP_TO_CLASSLENGTH
            state = STATE_CLASSLENGTH
            
          when STATE_SKIP_TO_CLASS
            state = STATE_CLASS
            
          when STATE_SKIP_TO_VALLENGTH
            state = STATE_VALLENGTH
            
          when STATE_SKIP_TO_VALUE
            state = STATE_VALUE
            
          when STATE_STRING
            if char == '"'
              @tokens << Token.new(TOKEN_STRING, @token)
              @token = ""
              state = STATE_SKIP
            else
              @token += char
            end
            
          when STATE_NUMBER
            if char == ';'
              @tokens << Token.new(TOKEN_NUMBER, @token)
              @token = ""
              state = STATE_DEFAULT
            else
              @token += char
            end
        end
      end
    end
    
    def type_identifier_lookup(char, state)
      # Is our char inside the list of types?
      if state == STATE_DEFAULT
        if TYPE_IDENITIFIERS.include?(char.downcase)
          @tokens << Token.new(TOKEN_TYPE_IDENITFIER, char.downcase)
          
          if char.downcase == 'c'
            STATE_SKIP_TO_CLASSLENGTH
          elsif char.downcase == 'n' || char.downcase == 'r'
            STATE_SKIP
          elsif char.downcase == 'i' || char.downcase == 'd'
            STATE_SKIP_TO_VALUE
          else
            STATE_SKIP_TO_VALLENGTH
          end
        elsif char == '}'
          @tokens << Token.new(TOKEN_END_OBJECT, true)
        end
      else
        STATE_VALUE
      end
    end
    
    def value_lookup(char)
      if char == '"'
        STATE_STRING
      elsif char.numeric?
        @token += char
        STATE_NUMBER
      elsif char == '{'
        STATE_DEFAULT
      end
    end
  end
  
  # Token represents a single token in the source code
  class Token
    attr_accessor :type
    attr_accessor :token
    
    def initialize(type, token)
      @type = type
      @token = token
    end
  end
end