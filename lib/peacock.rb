require 'git'
require 'peacock/logger'
require 'peacock/version'
require 'peacock/error'
require 'peacock/startup_manager'
require 'peacock/cli_hash'
require 'peacock/cli'
require 'peacock/engine/ignorer'


module Peacock

  def self.execute
    cli_hash = Peacock::CLI.parse
    Peacock::StartupManager.check_peacock_requirements
    Peacock::Engine::Ignorer.ignore(cli_hash)
  end

end
