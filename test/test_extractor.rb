require 'minitest_helper'

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
    refute extractor.hash_includes_line?("hi.txt")
  end

  def test_hash_includes_line_should_return_true_if_dir
    hash = Peacock::CLIHash.new
    hash.push :dirs, 'directory'
    extractor = Peacock::Engine::Extractor.new(hash)
    assert extractor.hash_includes_line?("directory\n")
    assert extractor.hash_includes_line?("directory")
  end

  def test_hash_includes_line_should_return_true_if_file
    hash = Peacock::CLIHash.new
    hash.push :files, 'file'
    extractor = Peacock::Engine::Extractor.new(hash)
    assert extractor.hash_includes_line?("file\n")
    assert extractor.hash_includes_line?("file")
  end

  def teardown
    FileUtils.rm_rf '/tmp/peacock'
    ARGV.clear
  end

end
