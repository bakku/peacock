require 'minitest_helper'

class TestCLIHash < Minitest::Test

  def setup
    @hash = Peacock::CLIHash.new
  end

  def teardown
  end

  def test_push_to_opts
    @hash.push(:opts, '-r')
    assert @hash.opts.include?('-r')
  end

  def test_root_ignore_should_be_true_for_r
    @hash.push(:opts, '-r')
    assert @hash.use_git_ignore_from_root_folder?
  end

  def test_root_ignore_should_be_true_for_root
    @hash.push(:opts, '--root')
    assert @hash.use_git_ignore_from_root_folder?
  end

  def test_root_ignore_should_be_true_for_both
    @hash.push(:opts, '-r')
    @hash.push(:opts, '--root')
    assert @hash.use_git_ignore_from_root_folder?
  end

  def test_root_ignore_should_be_false_without_r_or_root
    @hash.push(:opts, '-e')
    @hash.push(:opts, '--bla')
    refute @hash.use_git_ignore_from_root_folder?
  end

  def test_root_ignore_should_be_false_for_empty
    refute @hash.use_git_ignore_from_root_folder?
  end

  def test_silent_should_be_true_for_s
    @hash.push(:opts, '-s')
    assert @hash.silent?
  end

  def test_silent_should_be_true_for_silent
    @hash.push(:opts, '--silent')
    assert @hash.silent?
  end

  def test_silent_should_be_true_for_both
    @hash.push(:opts, '-s')
    @hash.push(:opts, '--silent')
    assert @hash.silent?
  end

  def test_silent_should_be_false_without_s_or_silent
    @hash.push(:opts, '-e')
    @hash.push(:opts, '-opt')
    refute @hash.silent?
  end

  def test_silent_should_be_false_for_empty
    refute @hash.silent?
  end

  def test_adding_directory_should_have_slashes_if_none_were_passed
    @hash.push(:dirs, 'test')
    @hash.dirs.include?('/test/')
  end

  def test_adding_directory_should_have_slashes_if_beginning_was_passed
    @hash.push(:dirs, '/test')
    @hash.dirs.include?('/test/')
  end

  def test_adding_directory_should_have_slashes_if_end_was_passed
    @hash.push(:dirs, 'test/')
    @hash.dirs.include?('/test/')
  end

  def test_adding_directory_should_have_slashes_if_both_were_passed
    @hash.push(:dirs, '/test/')
    @hash.dirs.include?('/test/')
  end

  def test_e_should_be_extractor
    @hash.push(:opts, '-e')
    assert_equal Peacock::Engine::Extractor, @hash.get_engine_class
  end

  def test_extract_should_be_extractor
    @hash.push(:opts, '--extract')
    assert_equal Peacock::Engine::Extractor, @hash.get_engine_class
  end

  def test_default_should_be_ignorer
    assert_equal Peacock::Engine::Ignorer, @hash.get_engine_class
  end

  def test_to_string_should_format_hash_correctly
    @hash.push(:opts, '-e')
    @hash.push(:dirs, 'directory')
    @hash.push(:files, 'file')
    assert_equal '{:opts=>["-e"], :files=>["file"], :dirs=>["/directory/"]}', @hash.to_s
  end

end
