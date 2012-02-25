module Pherialize
  
  # Pherialize::Parser takes in a Lexer object and
  # loops through its tokens, building up the object represented
  class Parser
    def self.parse(lexer)
      Parser.new(lexer).parse
    end
    
    def initialize(lexer)
      @tokens = lexer.tokens
      @position = 0
    end
    
    def parse
      
    end
    
    # -----------
    #   Token retrieval
    # -----------
    
    def current
      @tokens[@position]
    end
    
    def next(offset = 0)
      @tokens[@position + 1 + offset]
    end
    
    def previous(offset = 0)
      @tokens[@position - 1 - offset]
    end
    
    # -----------
    #   Token matching
    # -----------
    
    def match(token_one, token_two = false)
      if token_two == false
        if current.type == token_one
          @position += 1
          true
        else
          false
        end
      else
        if current.type == token_one
          if self.next.type == token_two
            @position += 1
            true
          else
            false
          end
        else
          false
        end  
      end
    end
    
    
  end
end