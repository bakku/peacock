require 'git'

require 'peacock/version'
require 'peacock/peacock_exception'
require 'peacock/startup_manager'

module Peacock

  def self.execute
    Peacock::StartupManager.new.check_peacock_requirements
  end

end
