require 'minitest_helper'
require 'fileutils'

class TestStartupManager < Minitest::Test
  
  def setup
    @startup = Peacock::StartupManager.new
    Dir.mkdir '/tmp/temptest'
    Dir.chdir '/tmp/temptest'
  end
  
  def teardown
    Dir.chdir '/tmp'
    FileUtils.rm_rf 'temptest'
  end
  
end
