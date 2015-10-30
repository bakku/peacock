module Peacock
  
  module Engine
    
    class Extractor
      include Peacock::Engine::Engine
      
      def self.start_engine(opt_hash)
        
      end
      
      def initialize(opt_hash)
        @hash = check_and_return_hash(opt_hash)
        @logger = Peacock::Logger.new(@hash.verbose?)
      end
    
    end
    
  end
  
end      