require 'fileutils'

module Peacock

  module Engine

    class Cleaner < Engine

      def self.start_engine(opt_hash)
        cleaner = Cleaner.new(opt_hash)
        cleaner.open_git_ignore
        cleaner.workflow
      end

      def open_git_ignore
        path = determine_git_ignore_path
        @git_ignore = File.open(path, 'a+')
      end

      def workflow
        extract_non_existing_entries
        @git_ignore.close
      end

      def extract_non_existing_entries
        current_entries = get_all_entries
        cleaned_up_list = create_cleaned_up_list(current_entries)
        reopen_git_ignore_in_read_mode
        write_cleaned_up_git_ignore(cleaned_up_list)
      end

      def get_all_entries
        @git_ignore.readlines
      end

      def create_cleaned_up_list(entries)
        cleaned_up_list = []

        entries.each do |entry|
          if entry_exists_on_file_system?(entry) || entry_is_a_comment?(entry)
            cleaned_up_list << entry
          end
        end

        cleaned_up_list
      end

      def entry_exists_on_file_system?(entry)
        File.exist? entry
      end

      def entry_is_a_comment?(entry)
        entry.start_with?('#')
      end

      def reopen_git_ignore_in_read_mode
        @git_ignore.reopen(@git_ignore.path, 'w')
      end

      def write_cleaned_up_git_ignore(clean_list)
        clean_list.each do |line|
          @git_ignore.write(line)
        end
      end

    end

  end

end
