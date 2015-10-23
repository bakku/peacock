require 'git'
require 'peacock/version'
require 'peacock/peacock_error'
require 'peacock/startup_manager'
require 'peacock/cli_hash'
require 'peacock/cli'
require 'peacock/ignorer'


module Peacock

  def self.execute
    Peacock::StartupManager.check_peacock_requirements
    cli_hash = Peacock::CLI.parse
    Peacock::Ignorer.ignore(cli_hash)
  end

end
