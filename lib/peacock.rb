require 'git'

require 'peacock/version'
require 'peacock/peacock_exception'
require 'peacock/startup_manager'
require 'peacock/parse_hash'
require 'peacock/parser'


module Peacock

  def self.execute
    Peacock::StartupManager.check_peacock_requirements
    Peacock::Parser.parse
  end

end
