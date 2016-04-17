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
      str = Formatter.format_directory_name(str) if type == :dirs

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

    def use_git_ignore_from_root_folder?
      opts.include?('-r') || opts.include?('--root')
    end

    def silent?
      opts.include?('-s') || opts.include?('--silent')
    end

    def get_engine_class
      if opts.include?('-e') || opts.include?('--extract')
        Peacock::Engine::Extractor
      elsif opts.include?('-c') || opts.include?('--cleanup')
        Peacock::Engine::Cleaner
      else
        Peacock::Engine::Ignorer
      end
    end

  end

end
