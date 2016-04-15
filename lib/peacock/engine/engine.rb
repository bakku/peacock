# some general engine code

module Peacock

  module Engine

    def self.execute(opt_hash)
      opt_hash.get_engine_class.start_engine(opt_hash)
    end

    class Engine

      GIT_IGNORE_FILE_NAME = '.gitignore'
      OS_ROOT_FOLDER = '/'

      def initialize(argument_hash)
        throw_cli_hash_error unless cli_hash?(argument_hash)
        @hash = argument_hash
        @logger = Peacock::Logger.new(@hash.silent?)
      end

      def cli_hash?(hash)
        hash.class == CLIHash
      end

      def throw_cli_hash_error
        raise PeacockError, "#{self.class} expects an instance of Peacock::CLIHash"
      end

      def determine_git_ignore_path
        if @hash.use_git_ignore_from_root_folder?
          return_git_ignore_in_root_git_folder
        else
          return_local_git_ignore_path
        end
      end

      def return_git_ignore_in_root_git_folder
        old_path = Dir.pwd

        change_to_git_root_folder
        git_ignore_root_folder_path = "#{Dir.pwd}/#{GIT_IGNORE_FILE_NAME}"
        Dir.chdir(old_path)
        git_ignore_root_folder_path
      end

      def change_to_git_root_folder
        while not root_git_folder?
          raise PeacockError, "#{GIT_IGNORE_FILE_NAME} does not exist" if Dir.pwd == OS_ROOT_FOLDER
          Dir.chdir '..'
        end
      end

      def root_git_folder?
        File.exist? '.git'
      end

      def return_local_git_ignore_path
        GIT_IGNORE_FILE_NAME
      end

      def git_ignore_exists?(path)
        File.exist?(path)
      end

    end

  end

end
