module Peacock

  module Engine

    class Extractor < Engine

      def self.start_engine(opt_hash)
        extractor = Extractor.new(opt_hash)
        extractor.open_git_ignore
        extractor.workflow
      end

      def open_git_ignore
        path = determine_git_ignore_path
        raise PeacockError, "#{self.class} expects .gitignore to exist at #{path}" unless git_ignore_exists?(path)
        @git_ignore = File.open(path, 'r')
      end

      def workflow
        extract_files_and_directories
        @git_ignore.close
      end

      def extract_files_and_directories
        current_git_ignore_entries = @git_ignore.readlines
        lines_to_be_deleted = determine_lines_to_be_deleted(current_git_ignore_entries)
        remaining_lines = current_git_ignore_entries - lines_to_be_deleted
        write_remaining_lines_to_git_ignore(remaining_lines)
      end

      def write_remaining_lines_to_git_ignore(remaining_lines)
        @git_ignore.reopen(@git_ignore.path, 'w')

        remaining_lines.each do |line|
          @git_ignore.write(line)
        end
      end

      def determine_lines_to_be_deleted(current_lines)
        [].tap do |delete_list|
          current_lines.each do |line|
            if delete_line?(line)
              delete_list.push(line)
              @logger.extract(line.chomp("\n"))
            end
          end
        end
      end

      def delete_line?(line)
        @hash.dirs.include?(Formatter.format_directory_name(line.chomp("\n"))) || @hash.files.include?(line.chomp("\n"))
      end

    end

  end

end
