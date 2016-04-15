require 'git'
require 'peacock/logger'
require 'peacock/version'
require 'peacock/error'
require 'peacock/formatter'
require 'peacock/startup_manager'
require 'peacock/argument_splitter'
require 'peacock/cli_hash'
require 'peacock/cli'
require 'peacock/engine/engine'
require 'peacock/engine/extractor'
require 'peacock/engine/ignorer'


module Peacock

  def self.execute
    cli_hash = Peacock::CLI.construct_cli_hash
    Peacock::StartupManager.check_peacock_requirements
    Peacock::Engine.execute(cli_hash)
  end

end
