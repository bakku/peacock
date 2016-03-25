module Peacock

  module Engine

    class Extractor
      include Peacock::Engine::Engine

      def self.start_engine(opt_hash)
        extractor = Extractor.new(opt_hash)
        extractor.open_git_ignore
        extractor.workflow
      end

      def initialize(opt_hash)
        @hash = check_and_return_hash(opt_hash)
        @logger = Peacock::Logger.new(@hash.silent?)
      end

      def open_git_ignore
        path = determine_git_ignore_path
        raise PeacockError, '#{self.class} expects .gitignore to exist at #{path}' unless git_ignore_exists?(path)

        # open in mode read-write (beginning of file)
        @git_ignore = File.open(path, 'r')
      end

      def workflow
        extract_files_and_directories
        @git_ignore.close
      end

      def extract_files_and_directories
        ignore_lines = @git_ignore.readlines

        # determine delete_list (cant use delete_if cause of logger logic)
        delete_list = determine_delete_list(ignore_lines)

        new_list = ignore_lines - delete_list

        # reopen in writable mode and input all new git ignore entries
        @git_ignore.reopen(@git_ignore.path, 'w')

        new_list.each do |line|
          @git_ignore.write(line)
        end
      end

      def determine_delete_list(ignore_lines)
        [].tap do |delete_list|
          ignore_lines.each_with_index do |line,index|
            if hash_includes_line?(line)
              delete_list.push(line)
              @logger.extract(line.chomp("\n"))
            end
          end
        end
      end

      def hash_includes_line?(line)
        @hash.dirs.include?(Formatter.format_dir(line.chomp("\n"))) || @hash.files.include?(line.chomp("\n"))
      end

    end

  end

end
