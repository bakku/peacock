require 'git'
require 'open3'

require 'peacock/version'
require 'peacock/peacock_exception'
require 'peacock/startup_manager'
require 'peacock/parse_hash'
require 'peacock/parser'
require 'peacock/ignorer'


module Peacock

  def self.execute
    Peacock::StartupManager.check_peacock_requirements
    parse_hash = Peacock::Parser.parse
    Peacock::Ignorer.ignore(parse_hash)
  end

end
