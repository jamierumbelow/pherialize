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
      @object = nil
    end
    
    def parse
      while true
        if current_token.token == 'a'
          @object = []
        elsif current_token.token == 'i'
          @object = next_token.token.to_i
          @position += 1
        end

        @position += 1
        break unless current_token
      end

      @object
    end
    
    # -----------
    #   Token retrieval
    # -----------
    
    def current_token
      @tokens[@position]
    end
    
    def next_token(offset = 0)
      @tokens[@position + 1 + offset]
    end
    
    def previous_token(offset = 0)
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