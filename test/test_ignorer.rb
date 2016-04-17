require 'minitest_helper'

class TestIgnorer < Minitest::Test

  def setup
    Dir.mkdir '/tmp/peacock'
    Dir.chdir '/tmp/peacock'
    Git.init
  end

  def teardown
    FileUtils.rm_rf '/tmp/peacock'
    ARGV.clear
  end

  def test_should_create_gitignore_if_it_does_not_exist
    ignorer = Peacock::Engine::Ignorer.new(Peacock::CLIHash.new)
    ignorer.open_or_create_git_ignore
    File.exist? '.gitignore'
  end

  def test_entry_exists_should_be_false
    ignorer = Peacock::Engine::Ignorer.new(Peacock::CLIHash.new)
    prepare_git_ignore
    ignorer.open_or_create_git_ignore
    refute ignorer.entry_exists? 'no_exist'
  end

  def test_entry_exists_should_be_true_for_correct_entry
    ignorer = Peacock::Engine::Ignorer.new(Peacock::CLIHash.new)
    prepare_git_ignore
    ignorer.open_or_create_git_ignore
    assert ignorer.entry_exists? 'file'
  end

  def test_entry_exists_should_be_true_for_entry_without_newline
    ignorer = Peacock::Engine::Ignorer.new(Peacock::CLIHash.new)
    prepare_git_ignore
    ignorer.open_or_create_git_ignore
    assert ignorer.entry_exists? 'directory'
  end

  def test_should_return_string_without_slash
    ignorer = Peacock::Engine::Ignorer.new(Peacock::CLIHash.new)
    assert_equal 'directory', ignorer.remove_leading_slash('/directory')
  end

  def test_should_not_change_string
    ignorer = Peacock::Engine::Ignorer.new(Peacock::CLIHash.new)
    assert_equal 'directory', ignorer.remove_leading_slash('directory')
  end

  def test_should_correctly_ignore_files
    cli_hash = Peacock::CLIHash.new
    cli_hash.push :opts, '-s'
    ignorer = Peacock::Engine::Ignorer.new(cli_hash)
    ignorer.open_or_create_git_ignore
    ignorer.insert_in_gitignore('hi')
    ignorer.instance_variable_get(:@git_ignore).close

    git_ignore = File.open('.gitignore', 'r')
    git_ignore_lines = git_ignore.readlines
    git_ignore.close
    assert_equal 1, git_ignore_lines.size
    assert_equal "hi\n", git_ignore_lines.first
  end

  def test_ignorer_full_test
    cli_hash = return_prepared_cli_hash
    Peacock::Engine::Ignorer.start_engine(cli_hash)

    git_ignore = File.open('.gitignore', 'r')
    git_ignore_lines = git_ignore.readlines
    git_ignore.close

    assert_equal 2, git_ignore_lines.size
    assert_equal "file\n", git_ignore_lines.first
    assert_equal "/directory/\n", git_ignore_lines[1]
  end

  private

  def return_prepared_cli_hash
    cli_hash = Peacock::CLIHash.new
    cli_hash.push :opts, '-s'
    cli_hash.push :dirs, 'directory'
    cli_hash.push :files, 'file'
    cli_hash
  end

  def prepare_git_ignore
    File.open('.gitignore', 'w') do |file|
      file.write "file\n"
      file.write "file2\n"
      file.write "directory"
    end
  end

end
