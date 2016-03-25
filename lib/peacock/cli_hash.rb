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
      str = Formatter.format_dir(str) if type == :dirs

      @hash[type].push(str)
    end

    def opts
      @hash[:opts]
    end

    def files
      @hash[:files]
    end

    def dirs
      @hash[:dirs]
    end

    def to_s
      hash.to_s
    end

    def root_ignore?
      opts.include?('-r') || opts.include?('--root')
    end

    def silent?
      opts.include?('-s') || opts.include?('--silent')
    end

    def engine
      if opts.include?('-e') || opts.include?('--extract')
        return Peacock::Engine::Extractor
      else
        return Peacock::Engine::Ignorer
      end
    end

  end

end
