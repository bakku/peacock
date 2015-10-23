module Peacock

  class CLIHash
    
    attr_reader :hash
    
    def initialize
      @hash = Hash.new
      @hash[:opts] = Array.new
      @hash[:files] = Array.new
      @hash[:dirs] = Array.new
    end
    
    def push(type, str)
      @hash[type].push(str)
    end
    
    def to_s
      hash.to_s
    end
    
  end
  
end
