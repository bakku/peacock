require 'minitest_helper'
require 'fileutils'

class TestExtractor < Minitest::Test

  def setup
    Dir.mkdir '/tmp/peacock'
    Dir.chdir '/tmp/peacock'
    Git.init
  end

  def test_should_throw_exception_without_gitignore
    extractor = Peacock::Engine::Extractor.new(Peacock::CLIHash.new)
    assert_raises Peacock::PeacockError do
      extractor.open_git_ignore
    end
  end

  def test_hash_includes_line_should_return_false
    extractor = Peacock::Engine::Extractor.new(Peacock::CLIHash.new)
    refute extractor.delete_line?("hi.txt")
  end

  def test_hash_includes_line_should_return_true_if_dir
    hash = Peacock::CLIHash.new
    hash.push :dirs, 'directory'
    extractor = Peacock::Engine::Extractor.new(hash)

    # try different formats
    assert extractor.delete_line?("directory\n")
    assert extractor.delete_line?("directory")
    assert extractor.delete_line?("/directory")
    assert extractor.delete_line?("directory/")
    assert extractor.delete_line?("/directory/")
  end

  def test_hash_includes_line_should_return_true_if_file
    hash = Peacock::CLIHash.new
    hash.push :files, 'file'
    extractor = Peacock::Engine::Extractor.new(hash)

    # try different formats
    assert extractor.delete_line?("file\n")
    assert extractor.delete_line?("file")
  end

  def test_delete_list_should_be_correct
    hash = Peacock::CLIHash.new
    hash.push :files, 'file'
    hash.push :dirs, 'directory'
    hash.push :opts, '-s'
    extractor = Peacock::Engine::Extractor.new(hash)

    ignore_lines = ['file', 'file2', 'directory']
    delete_list = extractor.determine_lines_to_be_deleted(ignore_lines)
    assert_equal ['file', 'directory'], delete_list
  end

  def test_full_extractor_test
    FileUtils.touch 'file'
    Dir.mkdir 'directory'

    File.open('.gitignore', 'w') do |file|
      file.write("file\n")
      file.write("file2\n")
      file.write("/directory/")
    end

    hash = Peacock::CLIHash.new
    hash.push :files, 'file'
    hash.push :dirs, 'directory'
    hash.push :opts, '-s'
    Peacock::Engine::Extractor.start_engine(hash)

    lines = []

    File.open('.gitignore', 'r') do |file|
      lines = file.readlines
    end

    assert_equal ["file2\n"], lines
  end

  def test_full_extractor_test_with_custom_directory_format
    FileUtils.touch 'file'
    Dir.mkdir 'directory'

    File.open('.gitignore', 'w') do |file|
      file.write("file\n")
      file.write("file2\n")
      file.write("directory/")
    end

    hash = Peacock::CLIHash.new
    hash.push :files, 'file'
    hash.push :dirs, 'directory'
    hash.push :opts, '-s'
    Peacock::Engine::Extractor.start_engine(hash)

    lines = []

    File.open('.gitignore', 'r') do |file|
      lines = file.readlines
    end

    assert_equal ["file2\n"], lines
  end

  def test_full_extractor_test_with_missing_entry
    FileUtils.touch 'file'
    Dir.mkdir 'directory'

    File.open('.gitignore', 'w') do |file|
      file.write("file\n")
      file.write("file2\n")
      file.write("directory/")
    end

    hash = Peacock::CLIHash.new
    hash.push :files, 'file'
    hash.push :dirs, 'directory'
    hash.push :files, 'does_not_exist'
    hash.push :opts, '-s'
    Peacock::Engine::Extractor.start_engine(hash)

    lines = []

    File.open('.gitignore', 'r') do |file|
      lines = file.readlines
    end

    assert_equal ["file2\n"], lines
  end

  def teardown
    FileUtils.rm_rf '/tmp/peacock'
    ARGV.clear
  end

end
