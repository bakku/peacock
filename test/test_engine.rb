require 'minitest_helper'

# Tests the engine model by using the ignorer engine
class TestEngine < Minitest::Test

  def setup
    Dir.mkdir '/tmp/peacock'
    Dir.chdir '/tmp/peacock'
    Git.init
  end

  def teardown
    FileUtils.rm_rf '/tmp/peacock'
    ARGV.clear
  end

  def test_should_take_current_directory_by_default
    ignorer = Peacock::Engine::Ignorer.new(Peacock::CLIHash.new)
    assert_equal '.gitignore', ignorer.determine_git_ignore_path
  end

  def test_should_throw_correct_exception
    ignorer = Peacock::Engine::Ignorer.new(Peacock::CLIHash.new)
    assert_raises Peacock::PeacockError do
      ignorer.throw_cli_hash_error
    end
  end

  def test_should_take_root_directory
    hash = Peacock::CLIHash.new
    hash.push :opts, '-r'
    ignorer = Peacock::Engine::Ignorer.new(hash)
    Dir.mkdir 'subdir'
    Dir.chdir '/tmp/peacock/subdir'
    assert_match '/tmp/peacock', ignorer.determine_git_ignore_path
  end

  def test_git_ignore_should_not_exist
    ignorer = Peacock::Engine::Ignorer.new(Peacock::CLIHash.new)

    path = ignorer.determine_git_ignore_path
    refute ignorer.git_ignore_exists?(path)
  end

  def test_git_ignore_should_exist
    ignorer = Peacock::Engine::Ignorer.new(Peacock::CLIHash.new)
    FileUtils.touch '.gitignore'

    path = ignorer.determine_git_ignore_path
    assert ignorer.git_ignore_exists?(path)
  end

  def test_git_ignore_should_exist_in_root_dir
    hash = Peacock::CLIHash.new
    hash.push :opts, '-r'
    ignorer = Peacock::Engine::Ignorer.new(hash)

    FileUtils.touch '.gitignore'
    Dir.mkdir 'subdir'
    Dir.chdir '/tmp/peacock/subdir'

    path = ignorer.determine_git_ignore_path
    assert ignorer.git_ignore_exists?(path)
  end
end
