require 'minitest_helper'

class TestStartupManager < Minitest::Test

  def setup
    Dir.mkdir '/tmp/peacock'
    Dir.chdir '/tmp/peacock'
  end

  def teardown
    FileUtils.rm_rf '/tmp/peacock'
    ARGV.clear
  end

  def test_startup_manager_should_throw_an_exception_if_not_a_repository
    assert_raises NoGitRepositoryError do
      Peacock::StartupManager.check_peacock_requirements
    end
  end

  def test_startup_manager_should_not_throw_an_exception_if_in_repository
    Git.init
    Peacock::StartupManager.check_peacock_requirements
  end

end
